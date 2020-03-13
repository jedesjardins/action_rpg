# Action RPG

At the moment, this repository is just my foray into making an action rpg game. Building up the systems, trying out assets, AI Behaviors, the like.

# Interesting Tidbits

## This game is Pixel Perfect! (ish)

There are many guides out there claiming to be able to draw a pixel perfect game at multiple resolutions, but many of these seem just downright wrong.

One solution is to set the window stretch_mode to 2D and then get the root viewport and set_override_size to the new resolution (scaled down). But I have some problems with this.
1. First, the pixels ARE a uniform size if the scale from your target resolution to the actual resolution is an integer. If it isn't an integer however you get non-uniform pixel sizes, much like if you just set the stretch_mode to Viewport and resized.
2. This method allows entites whose positions are decimals to be drawn on non-pixel boundaries i.e. NOT PIXEL PERFECT

My solution:
1. Have a single main scene which is ALWAYS RUNNING
2. This main scene has a child Viewport at a predefined "max_size" (the largest renderable area you are willing to show)
3. The main scene also has a child Sprite who renders the Viewport Texture
4. Any "running scenes" must be instanced under the viewport(remember the main scene always must be the root scene)
5. Upon resize, draw from a scaled up sub-section of the viewport in the Sprite using a script on the root node like this:
```
onready var root = get_tree().get_root()
export(Vector2) var max_size

func _ready():

	root.connect("size_changed", self, "window_resize")
	window_resize()

func window_resize():
	var window_size = OS.get_window_size()
	root.set_size_override(true, window_size)

	var float_scale = window_size / max_size

	var rounded_scale = max(ceil(float_scale.x), ceil(float_scale.y))

	var rounded_scale_vec = Vector2(rounded_scale, rounded_scale)

	var sub_viewport_size = window_size / rounded_scale_vec

	$"Viewport".set_size_override(true, sub_viewport_size)
	$"ViewportSprite".scale = rounded_scale_vec
```

This ensures that you are always drawing a sub section of max_size, and the pixels on screen are uniformly sized, and everything is drawn on pixel boundaries.

Trade-Offs:
* The "ish" in Pixel Perfect (ish) comes from the fact that if there isn't a perfect integer scale between the target resolution and actual resolution, it will clip off part of the edge pixels on one side. For example, if your screen is 99 pixels wide, but you want to draw a 10 pixel wide image, the scale should obviously be about 10x, but the actual scale is 9.9x. This method still selects 10x, so you're drawing your 10px wide image at 100 px, but it clips off .1px along the right side. But this way all the other pixels are a uniform size.
* you can't use change_scene or whatever anymore, oh well. Write your own change scene which swaps the scene under the Viewport.
* if you still allow sprites to have float positions, moving the camera around can cause them to jitter back and forth, fix this by ensuring sprites always have an integer position.

## BaseEntity

I figure that most entities in the game, like the player, NPC's enemies, etc. will all have some sort of physics body, (in Godot a KinematicBody2D or StaticBody2D, etc), and Behavior (maybe a Behavior Tree, or an in-game cut scene Script that is triggered when the player gets close)

So I outlined this class: BaseEntity

It requires two children nodes to be specified:
* PhysicsBody - inherits from BasePhysicsBody. This class works under the assumption that most entities will have things like Colliders, Hitboxes, Hurtboxes, and Hands to hold items, along with some sort of visuals to go along with it.
* BehaviorBody - inherits from BaseBehavior. This class assumes that entities will also have behavior, whether it's an enemy that attacks a player, or an npc that sells items to the player.

That way you can easily reuse physics bodies for things that look the same, but attach a different behavior nodes to them for them to act different. Maybe like if you want your player character to change appearance, or even entirely change species!

## Behavior Trees

These can be used to define behaviors of anything from the player, to an NPC, to a door.

Built around BTNodes and the tick function: `func tick(blackboard: Dictionary) -> int`, it has a single child that it can run.

There are some generic nodes that can help build up flows of behaviors easily:

### BTNode

The generic node class, everything related to the Behavior Tree inherits from this node.

It has a `func tick(blackboard: Dictionary) -> int` that needs to either return `OK`, `FAILED`, or `ERR_BUSY`, where `ERR_BUSY` means that the node is still running

### Composite Nodes

These are nodes with multiple children. Their classes can be found in `res://infra/bt/composites` with the base class at `res://infra/bt/composite.gd`

#### Sequence

This node will run each child node in order as long as each child returns `OK`. If any child returns `ERR_BUSY` or `FAILED` the sequence node will return that value immediately. It will resume with a still running child on the next tick without starting at the beginning of it's children.

You can think of this as the AND operator of your language and how it short circuits if any of the conditions to the operator return false

This class can be found in `res://infra/bt/composites/sequence.gd`

#### Selector

This node will run each child node in order as long as each child returns `FAILED`. If any child returns `ERR_BUSY` or `OK` the sequence node will return that value immediately. It will resume with a still running child on the next tick without starting at the beginning of it's children.

You can think of this as the OR operator of your language and how it short circuits if any of the conditions to the operator return true

This class can be found in `res://infra/bt/composites/selector.gd`

### Decorator Nodes

These are nodes with only one child

#### Fail

This node will always return `FAILED`, unless it's child returns `ERR_BUSY`, in which case it returns `ERR_BUSY`

#### Suceed

This node will always return `OK`, unless it's child returns `ERR_BUSY`, in which case it returns `ERR_BUSY`

#### Not

This node will return `OK` if it's child returns `FAILED` and vice versa, unless it's child returns `ERR_BUSY`, in which case it returns `ERR_BUSY`

#### Repeat

This node will return `ERR_BUSY` if it's child returns `OK` or `ERR_BUSY`, it returns `OK` if it's child returns `OK`

This is a good node for simulating a while loop when it has a single Sequence child. Something like this:

```
while(Condition A and Condition B ...):
	run Behavior
```
turns into:
```
Repeat
| Sequence
| | Condition A
| | Condition B
| | ...
| | Behavior Node
```
where you can put the conditions at the beginning of the sequence. If any Condition fails, the sequence fails and never runs the Behavior Node, but if all the conditions pass, and the behavior node passes, then Repeat will return `ERR_BUSY` and so next `tick` will run the "loop" again.

# Project Files Structure

In trying to keep this project clean, I have a few main directories:

* resource - pretty explanatory, this is where I place textures, fonts, shaders, etc.
* infra - this is where generic, reusable scripts and scenes are placed. If you can imagine using a class throughout multiple scenes, this may be the place to put it.
	* bt - this folder is specifically for classes related to Behavior Trees
	* entity - this is specifically for generic classes related to my BaseEntity class
	* scripts - this is for the generic classes for run time scripts (think classes outlining in-game cut scenes, dialogues, etc)
* inst - this is where specific scenes and scripts are placed
	* entities - this is where any instances of generic classes (from the infra directory) that may be used in many scenes are placed, things like the player, NPC's etc.
	* scenes - this is where any game scenes are placed, think menu screen scenes, in game scenes, etc. If any instance of an entity or script is specific to a single scene, it should also be placed here.