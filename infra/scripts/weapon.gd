tool
extends InteractScript

class_name Weapon

export var json_path: String
var attacks: Dictionary
onready var charge_attack = ""

var sprite: Sprite
var animation_player: AnimationPlayer
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
	
	# read attacks
	assert(parsed_dict.has("attacks"))
	attacks = parsed_dict.attacks
	
	if parsed_dict.has("charge_attack"):
		charge_attack = attacks[parsed_dict.charge_attack]
	
	# instance the scene located at item_scene
	assert(parsed_dict.has("item_scene"))
	var item_scene = load(parsed_dict.item_scene)
	var instanced_item = item_scene.instance()
	add_child(instanced_item)
	
	# get the sprite from the item scene
	assert(instanced_item.has_node("Sprite"))
	sprite = instanced_item.get_node("Sprite")
	
		# get the sprite from the item scene
	assert(instanced_item.has_node("AnimationPlayer"))
	animation_player = instanced_item.get_node("AnimationPlayer")
	
	# get the trigger from the item scene
	assert(instanced_item.has_node("Trigger"))
	trigger = instanced_item.get_node("Trigger")
	trigger.logical_parent = self
	var _err = trigger.connect("body_entered", self, "trigger_entered")
	_err = trigger.connect("body_exited", self, "trigger_exited")
	
	# connect the items hitbox to a deal damage function
	# right now assume the root of the item is an Area2D
	assert(instanced_item.has_node("Hitbox"))
	hitbox = instanced_item.get_node("Hitbox")
	hitbox.logical_parent = self
	_err = hitbox.connect("body_entered", self, "hit_body")
	_err = hitbox.connect("area_entered", self, "hit_area")


func hit_body(_body):
	pass
	# should hit_body even be called?

func hit_area(area):
	var hitbox_bit = 1
	var hurtbox_bit = 2
	
	if area == hitbox_ignored_node:
		return
	
	if area.get_collision_layer_bit(hurtbox_bit):
		pass
		# Deals damage to hurtbox owner
	elif area.get_collision_layer_bit(hitbox_bit):
		pass
		# weapon clash (stun lock mechanic here?)

# TODO: set_ignore(entity.hurtbox)
func held_by(entity: Node):
	# set the trigger to ignore the entity
	set_ignore(entity)
	trigger.get_node("CollisionShape2D").disabled = true
	
	hitbox_ignored_node = entity.hurtbox

func drop():
	animation_player.play("drop")
	
	var timer = Timer.new()
	add_child(timer)
	timer.start(1)
	yield(timer, "timeout")
	remove_child(timer)
	timer.queue_free()
	
	# wait until timer finished
	set_ignore(null)
	trigger.get_node("CollisionShape2D").disabled = false
	
	hitbox_ignored_node = null

func interact(interactor):
	assert(interactor.get_entity() != null)
	
	interactor.get_entity().hold_item(self)
	sprite.unhighlight()

func is_interacting() -> bool:
	return false

func trigger_entered(body):
	if body is ChildPhysicsBody:
		body.emit_signal("entered_area", self, sprite)

func trigger_exited(body):
	if body is ChildPhysicsBody:
		body.emit_signal("exited_area", self)
