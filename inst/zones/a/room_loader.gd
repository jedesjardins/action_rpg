tool
extends Area2D

class_name RoomLoader

export(String, FILE) var room_path setget set_room_path
export(Array, NodePath) var visible_room_loaders
var room_node: Node

signal make_active
signal make_inactive

func _ready():
	if Engine.is_editor_hint() and room_path != "":
		load_room()

	var _err = self.connect("body_entered", self, "make_active")
	_err = self.connect("body_exited", self, "make_inactive")

func make_active(body):
	if body.is_in_group("player"):
		emit_signal("make_active", self)

func make_inactive(body):
	if body.is_in_group("player"):
		emit_signal("make_inactive", self)

func room_is_loaded():
	return room_node != null

func load_room():
	if not room_node:
		var room_scene = load(room_path)
		if room_scene == null:
			return

		room_node = room_scene.instance()
		add_child(room_node)

func unload_room():
	if room_node:
		room_node.queue_free()
		room_node = null

func set_room_path(new_room_path: String):
	var loaded = room_is_loaded()
	if loaded:
		unload_room()

	room_path = new_room_path

	if room_path != "" and (loaded or Engine.is_editor_hint()):
		load_room()
