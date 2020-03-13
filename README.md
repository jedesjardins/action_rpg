# Action RPG

At the moment, this repository is just my foray into making an action rpg game. Building up the systems, trying out assets, AI Behaviors, the like.

# Interesting Tidbits

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

This node will always return `FAILED` unless it's child returns `ERR_BUSY`

#### Suceed

This node will always return `OK` unless it's child returns `ERR_BUSY`

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