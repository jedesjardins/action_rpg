
class_name Weapon
extends Node2D

export var configuration_path: String

var configuration: Dictionary
var icon: String

func _ready():
	if Engine.is_editor_hint():
		return

	var file = File.new()
	assert(file.file_exists(configuration_path))
	file.open(configuration_path, 1)
	var parse_result = JSON.parse(file.get_as_text())
	assert(parse_result.error == OK)

	configuration = parse_result.result

	icon = configuration.icon

#tool
#extends InteractScript
#
#class_name Weapon
#
#export var json_path: String
#
#var attack_info: AttackInfo
#
#var sprite: Sprite
#var icon: String
#var animation_player: AnimationPlayer
#var hitbox: Area2D
#var trigger: Area2D
#var hitbox_ignored_node: Node
#
#func _ready():
#	# read json file at json_path
#	# parse into dictionary
#	var file = File.new()
#	assert(file.file_exists(json_path))
#	file.open(json_path, 1)
#	var parse_result = JSON.parse(file.get_as_text())
#	assert(parse_result.error == OK)
#
#	var parsed_dict = parse_result.result
#
#	# read icon
#	assert(parsed_dict.has("icon") and parsed_dict.icon is String)
#	icon = parsed_dict.icon
#
#	attack_info = AttackInfo.new(parsed_dict)
#
#	# instance the scene located at item_scene
#	assert(parsed_dict.has("item_scene"))
#	var item_scene = load(parsed_dict.item_scene)
#	var instanced_item = item_scene.instance()
#	add_child(instanced_item)
#
#	# get the sprite from the item scene
#	assert(instanced_item.has_node("Sprite"))
#	sprite = instanced_item.get_node("Sprite")
#
#		# get the sprite from the item scene
#	assert(instanced_item.has_node("AnimationPlayer"))
#	animation_player = instanced_item.get_node("AnimationPlayer")
#
#	# get the trigger from the item scene
#	assert(instanced_item.has_node("Trigger"))
#	trigger = instanced_item.get_node("Trigger")
#
#	var _err = trigger.connect("body_entered", self, "on_Trigger_body_entered")
#	_err = trigger.connect("body_exited", self, "on_Trigger_body_exited")
#
#	# connect the items hitbox to a deal damage function
#	# right now assume the root of the item is an Area2D
#	assert(instanced_item.has_node("Hitbox"))
#	hitbox = instanced_item.get_node("Hitbox")
#
#	_err = hitbox.connect("body_entered", self, "on_Hitbox_body_entered")
#	_err = hitbox.connect("area_entered", self, "on_Hitbox_area_entered")
#
#	assert(parsed_dict.has("damage_infos"))
#	if not Engine.is_editor_hint():
#		hitbox.all_damage_infos = parsed_dict.damage_infos
#
#
#func on_Hitbox_body_entered(_body):
#	pass
#	# should hit_body even be called?
#
#func on_Hitbox_area_entered(area):
#	var hitbox_bit = 1
#	var hurtbox_bit = 2
#
#	if area == hitbox_ignored_node:
#		return
#
#	if area.get_collision_layer_bit(hurtbox_bit):
#		pass
#		# Deals damage to hurtbox owner
#	elif area.get_collision_layer_bit(hitbox_bit):
#		pass
#		# weapon clash (stun lock mechanic here?)
#
## TODO: set_ignore(entity.hurtbox)
#func held_by(entity: Entity):
#	# set the trigger to ignore the entity
#	set_ignore(entity)
#	trigger.get_node("CollisionShape2D").disabled = true
#
#	if entity.has_node("Hurtbox"):
#		hitbox_ignored_node = entity.get_node("Hurtbox")
#
#	sprite.set_process(false)
#
#func drop():
#	animation_player.play("drop")
#	sprite.set_process(true)
#
#	var timer = Timer.new()
#	add_child(timer)
#	timer.start(1)
#	yield(timer, "timeout")
#	remove_child(timer)
#	timer.queue_free()
#
#	# wait until timer finished
#	set_ignore(null)
#	trigger.get_node("CollisionShape2D").disabled = false
#
#	hitbox_ignored_node = null
#
#func interact(entity):
#	if entity.has_node("Hand"):
#		entity.get_node("Hand").hold_item(self)
#
#	sprite.unhighlight()
#
#func is_interacting() -> bool:
#	return false
#
#func on_Trigger_body_entered(body):
#	if body is Entity and body.has_node("Interact"):
#		# TODO: remove sprite here
#		body.get_node("Interact").add_interact_script(self, sprite)
#
#func on_Trigger_body_exited(body):
#	if body is Entity and body.has_node("Interact"):
#		body.get_node("Interact").remove_interact_script(self)
