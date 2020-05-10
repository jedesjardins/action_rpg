tool

class_name Entity

extends ChildPhysicsBody # extends KinematicBody2D

export var appearance_path: NodePath
var appearance: Node

export var trigger_path: NodePath
var trigger: Area2D

export var hitbox_path: NodePath
var hitbox: Area2D

export var hurtbox_path: NodePath
var hurtbox: Area2D

export var hand_path: NodePath
var hand: Node2D

export var behavior_path: NodePath
var behavior: BaseBehavior

export var json_path: String
var walk_speed: int

var direction: int
var action: int

func _ready():
	if Engine.is_editor_hint():
		return

	var file = File.new()
	assert(file.file_exists(json_path))
	file.open(json_path, 1)
	var parse_result = JSON.parse(file.get_as_text())
	assert(parse_result.error == OK)

	var parsed_dict = parse_result.result
	assert(parsed_dict.has("walk_speed"))
	walk_speed = parsed_dict.walk_speed

	if trigger_path:
		trigger = get_node(trigger_path)

	if appearance_path:
		appearance = get_node(appearance_path)

	if hitbox_path:
		hitbox = get_node(hitbox_path)
		assert(hitbox is ChildArea)
		hitbox.logical_parent = self
		assert(parsed_dict.has("damage_infos"))
		hitbox.all_damage_infos = parsed_dict.damage_infos

	if hurtbox_path:
		hurtbox = get_node(hurtbox_path)
		assert(hurtbox is ChildArea)
		hurtbox.logical_parent = self

	if behavior_path:
		behavior = get_node(behavior_path)
		behavior.set_entity(self)

	if hand_path:
		hand = get_node(hand_path)

func has_trigger() -> bool:
	return trigger != null

func get_trigger() -> Node:
	return trigger

func has_hitbox() -> bool:
	return hitbox != null

func get_hitbox() -> Node:
	return hitbox

func has_hurtbox() -> bool:
	return hurtbox != null

func get_hurtbox() -> Node:
	return hurtbox

func has_appearance() -> bool:
	return appearance != null

func get_appearance() -> Node:
	return appearance

func has_behavior() -> bool:
	return behavior != null

func get_behavior() -> Node:
	return behavior

func hold_item(var item_node: Weapon):
	assert(item_node)

	if hand != null:
		if item_node.get_parent():
			item_node.get_parent().remove_child(item_node)

		hand.add_child(item_node)
		item_node.position = Vector2(0, 0)

		item_node.held_by(self)

		if behavior:
			behavior.set_item(item_node)


func drop_item():
	if hand != null and hand.get_child_count() == 1:
		var item_node = hand.get_children()[0]
		var cached_position = item_node.global_position
		print(cached_position)

		hand.remove_child(item_node)

		var zone_path = Helpers.get_zone_path_of(self)
		var zone = get_node(zone_path)

		var room_loaders = zone.entities_current_rooms[self.get_path()]
		assert(room_loaders.size() > 0)
		print(room_loaders[0], room_loaders[0].get_path())
		room_loaders[0].get_room().add_child(item_node)
		item_node.global_position = cached_position

		item_node.drop()
		behavior.set_item(null)

func animated_move(magnitude):
	var mouse_position = Helpers.get_viewport_mouse_position(get_viewport())
	var vector_to_mouse = (mouse_position - self.global_position).normalized()
	vector_to_mouse *= magnitude
	var _collision = move_and_collide(vector_to_mouse)
