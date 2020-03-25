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
	var file = File.new()
	assert(file.file_exists(json_path))
	file.open(json_path, 1)
	var parse_result = JSON.parse(file.get_as_text())
	assert(parse_result.error == OK)
	
	var parsed_dict = parse_result.result
	
	assert(parsed_dict.has("item_scene"))
	var item_scene = load(parsed_dict.item_scene)
	var instanced_item = item_scene.instance()
	add_child(instanced_item)
	
	assert(instanced_item.has_node("Sprite"))
	sprite = instanced_item.get_node("Sprite")
	
	assert(instanced_item.has_node("Trigger"))
	trigger = instanced_item.get_node("Trigger")
	
	var err = trigger.connect("body_entered", self, "trigger_entered")
	if err != OK:
		print("Error initializing Weapon class")
	
	err = trigger.connect("body_exited", self, "trigger_exited")
	if err != OK:
		print("Error initializing Weapon class")
	
	assert(parsed_dict.has("attacks"))
	var attacks = parsed_dict.attacks
	for key in parsed_dict.attacks.keys():
		var aa = AttackAnimation.new(attacks[key])
		attack_animations[key] = aa
	
	

func held_by(physics_body: Node):
	set_ignore(physics_body)
	hitbox_ignored_node = physics_body
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
	interactor.hold_item(self)
	sprite.unhighlight()

func is_interacting() -> bool:
	return false

func trigger_entered(body):
	print("Weapon Trigger Entered")
	# Change this to if body can hold items
	if body.is_in_group("player") and body != ignored_node:
		sprite.highlight()
		body.get_parent().behavior_body.add_interact_script(self)

func trigger_exited(body):
	if body.is_in_group("player") and body != ignored_node:
		sprite.unhighlight()
		body.get_parent().behavior_body.remove_interact_script(self)
