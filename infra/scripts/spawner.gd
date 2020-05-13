tool
extends Node2D

# spawns the entity instanced from "spawn_scene_path" under the parent zone
class_name Spawner

export(String, FILE) var spawn_scene_path
var loaded_scene: Reference
export(bool) var spawn_on_ready = true
export(bool) var keep_loaded # load the scene at ready and keep it loaded
var zone: Node

func _ready():
	var zone_path = Global.get_zone_path_of(self)
	zone = get_node(zone_path)

	if spawn_on_ready or Engine.is_editor_hint():
		var _spawned_node = spawn()

func spawn():
	var spawn_scene: Reference
	if loaded_scene != null:
		spawn_scene = loaded_scene
	else:
		spawn_scene = load(spawn_scene_path)
		if keep_loaded:
			loaded_scene = spawn_scene

	if spawn_scene == null:
		return null

	var spawned_node = spawn_scene.instance()

	if Engine.is_editor_hint():
		add_child(spawned_node)
	else:
		zone.add_child(spawned_node)
		spawned_node.position = position

	return spawned_node
