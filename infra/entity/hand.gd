
class_name Hand
extends Node2D

signal item_held
signal item_dropped

export var z_modifier: int
export var item_held_direction: String

var item: Weapon

func hold_item(item_node):

	if item_node.get_parent():
		item_node.get_parent().remove_child(item_node)

		add_child(item_node)
		item_node.position = Vector2(0, 0)

		item_node.held_by(get_parent())
		item = item_node

		emit_signal("item_held", item)

func drop_item():
	if item:
		var cached_position = item.global_position

		remove_child(item)

		var zone_path = Helpers.get_zone_path_of(self)
		var zone = get_node(zone_path)

		var room_loaders = zone.entities_current_rooms[self.get_path()]
		assert(room_loaders.size() > 0)
		print(room_loaders[0], room_loaders[0].get_path())
		room_loaders[0].get_room().add_child(item)
		item.global_position = cached_position

		item.drop()

		var cached_item = item
		item = null
		emit_signal("item_dropped", cached_item)
