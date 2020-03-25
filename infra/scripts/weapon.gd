tool
extends InteractScript

class_name Weapon

class AnimationStage:
	var item_animation: String
	var entity_animation: String
	var duration: float
	
	func _init(d: Dictionary):
		item_animation = d.item_animation
		entity_animation = d.entity_animation
		duration = d.duration

class AttackAnimation:
	var warmup_animation: AnimationStage
	var main_animation: AnimationStage
	var cooldown_animation: AnimationStage
	
	func _init(d: Dictionary):
		warmup_animation = AnimationStage.new(d.warmup)
		main_animation = AnimationStage.new(d.main)
		cooldown_animation = AnimationStage.new(d.cooldown)

export var json_path: String
var attack_animations: Dictionary

var sprite: Sprite
var hitbox: Area2D
var trigger: Area2D
var hitbox_ignored_node: Node

func _ready():
	# read json file at json_path
	# parse into dictionary
	var file = File.new()
	assert(file.file_exists(json_path))
	file.open(json_path, 1)
	var parse_result = JSON.parse(file.get_as_text())
	assert(parse_result.error == OK)
	
	var parsed_dict = parse_result.result
	
	# instance the scene located at item_scene
	assert(parsed_dict.has("item_scene"))
	var item_scene = load(parsed_dict.item_scene)
	var instanced_item = item_scene.instance()
	add_child(instanced_item)
	
	# get the sprite from the item scene
	assert(instanced_item.has_node("Sprite"))
	sprite = instanced_item.get_node("Sprite")
	
	# get the trigger from the item scene
	assert(instanced_item.has_node("Trigger"))
	trigger = instanced_item.get_node("Trigger")
	
	# connect the item trigger to be able to be picked up
	var err = trigger.connect("body_entered", self, "trigger_entered")
	if err != OK:
		print("Error initializing Weapon class")
	
	err = trigger.connect("body_exited", self, "trigger_exited")
	if err != OK:
		print("Error initializing Weapon class")
	
	# connect the items hitbox to a deal damage function
	# right now assume the root of the item is an Area2D
	assert(instanced_item is Area2D)
	hitbox = instanced_item
	err = hitbox.connect("body_entered", self, "hit_body")
	err = hitbox.connect("area_entered", self, "hit_area")
	
	# parse the attack definitions (animations and durations)
	assert(parsed_dict.has("attacks"))
	var attacks = parsed_dict.attacks
	for key in parsed_dict.attacks.keys():
		var aa = AttackAnimation.new(attacks[key])
		attack_animations[key] = aa

func hit_body(_body):
	print("Should hit_body even be called???")

func hit_area(area):
	var hitbox_bit = 1
	var hurtbox_bit = 2
	
	if area == hitbox_ignored_node:
		return
	
	if area.get_collision_layer_bit(hurtbox_bit):
		print("Dealing damage to ", area.get_path())
	elif area.get_collision_layer_bit(hitbox_bit):
		print("Clashing with other hitbox ", area.get_path())

# TODO: set_ignore(entity.hurtbox)
func held_by(entity: Node):
	# set the trigger to ignore the entity
	set_ignore(entity)
	hitbox_ignored_node = entity.hurtbox
	trigger.get_node("CollisionShape2D").disabled = true

func drop():
	set_ignore(null)
	hitbox_ignored_node = null
	trigger.get_node("CollisionShape2D").disabled = false

func set_direction(direction: int): # pass in direction enum
	match direction:
		Helpers.Direction.DOWN:
			sprite.frame = 0
		Helpers.Direction.DOWN_RIGHT:
			sprite.frame = 1
		Helpers.Direction.RIGHT:
			sprite.frame = 2
		Helpers.Direction.UP_RIGHT:
			sprite.frame = 3
		Helpers.Direction.UP:
			sprite.frame = 4
		Helpers.Direction.UP_LEFT:
			sprite.frame = 5
		Helpers.Direction.LEFT:
			sprite.frame = 6
		Helpers.Direction.DOWN_LEFT:
			sprite.frame = 7

func interact(interactor):
	assert(interactor.get_entity() != null)
	
	interactor.get_entity().hold_item(self)
	sprite.unhighlight()

func is_interacting() -> bool:
	return false

func trigger_entered(body):
	print("Weapon Trigger Entered")
	# Change this to if body can hold items
	if body.is_in_group("player") and body != ignored_node:
		assert(body.behavior != null)
		
		sprite.highlight()
		body.behavior.add_interact_script(self)

func trigger_exited(body):
	if body.is_in_group("player") and body != ignored_node:
		assert(body.behavior != null)
		
		sprite.unhighlight()
		body.behavior.remove_interact_script(self)
