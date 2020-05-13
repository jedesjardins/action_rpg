tool

class_name RoomLoader
extends Area2D

signal make_active
signal make_inactive

export(String, FILE) var room_path setget set_room_path
export(Array, NodePath) var visible_room_loaders

var room_node: Node setget set_room, get_room
var zone: Node

var Log = Logger.get_logger("room_loader.gd")

func _ready():
	if not Engine.is_editor_hint():
		Log.trace("ready", "_ready()")

	var zone_path = Helpers.get_zone_path_of(self)
	zone = get_node(zone_path)

	if Engine.is_editor_hint() and room_path != "":
		load_room()

	var _err = connect("body_entered", self, "on_body_entered")
	_err = connect("body_exited", self, "on_body_exited")

func on_body_entered(body):
	if not Engine.is_editor_hint():
		Log.trace("body entered", "on_body_entered(body)")

	zone.add_entity_to_room(body, self)

	if body.is_in_group("player"):
		emit_signal("make_active", self)

func on_body_exited(body):
	if not Engine.is_editor_hint():
		Log.trace("body exited", "on_body_exited(body)")
	# remove the player from the zone before making it inactive
	if body.is_in_group("player"):
		zone.remove_entity_from_room(body, self, false)
		emit_signal("make_inactive", self)
	else:
		zone.remove_entity_from_room(body, self)

func room_is_loaded():
	if not Engine.is_editor_hint():
		Log.trace("Room is loaded", "room_is_loaded()")

	return room_node != null


func load_room():
	if not Engine.is_editor_hint():
		Log.trace("load_room", "load_room()")
	if not room_node:
		var room_scene = load(room_path)
		if room_scene == null:
			return

		room_node = room_scene.instance()
		add_child(room_node)

func unload_room():
	if not Engine.is_editor_hint():
		Log.trace("unload room", "unload_room()")
	if room_node:
		room_node.queue_free()
		room_node = null

func set_room_path(new_room_path: String):
	if not Engine.is_editor_hint():
		Log.trace("setting room path to %s" % new_room_path, "set_room_path(String)")
	var loaded = room_is_loaded()
	if loaded:
		unload_room()

	room_path = new_room_path

	if room_path != "" and (loaded or Engine.is_editor_hint()):
		load_room()

func set_room(_new_room):
	assert(false)

func get_room():
	return room_node
