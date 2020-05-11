tool

class_name Entity
extends ChildPhysicsBody # extends KinematicBody2D

export var json_path: String

var sprite: Sprite setget set_sprite
var trigger: Area2D setget set_trigger
var hitbox: Hitbox setget set_hitbox
var hurtbox: Hurtbox setget set_hurtbox
var hand: Hand setget set_hand
var behavior: BaseBehavior setget set_behavior

var walk_speed: int

var damage_info: Dictionary
var attack_info: AttackInfo

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

	damage_info = parsed_dict.get("damage_infos", {})
	if parsed_dict.has("attacks") and parsed_dict.has("first_attack"):
		attack_info = AttackInfo.new(parsed_dict)

	print("Entity ", self.get_path())
	for child in get_children():
		if child is Sprite:
			print("found Sprite")
			set_sprite(child)
		elif child is Hitbox:
			print("found Hitbox")
			set_hitbox(child)
		elif child is Hurtbox:
			print("found Hurtbox")
			set_hurtbox(child)
		elif child is Area2D:
			print("found Area2D")
			set_trigger(child)
		elif child is Hand:
			print("found Hand")
			set_hand(child)
		elif child is BaseBehavior:
			print("found BaseBehavior")
			set_behavior(child)

func set_sprite(s: Sprite):
	sprite = s

func set_trigger(a: Area2D):
	trigger = a

func set_hitbox(h: Hitbox):
	hitbox = h
	hitbox.logical_parent = self

	hitbox.all_damage_infos = damage_info

func set_hurtbox(h: Hurtbox):
	hurtbox = h
	hurtbox.logical_parent = self

func set_hand(h: Hand):
	hand = h

func set_behavior(b: BaseBehavior):
	print("Set behavior ", self, " ", get_path())
	behavior = b
	behavior.set_entity(self)

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

func animated_move(magnitude: int):
	var mouse_position = Helpers.get_viewport_mouse_position(get_viewport())
	var vector_to_mouse = (mouse_position - self.global_position).normalized()

	animated_move2(vector_to_mouse, magnitude)

func animated_move2(vector: Vector2, magnitude: int):
	var _collision = move_and_collide(vector * magnitude)
