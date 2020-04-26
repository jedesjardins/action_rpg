tool
extends Node2D

# spawns the entity at the scene loaded by spawns under the parent game state
class_name Spawner

export(String, FILE) var spawn_scene_path
var loaded_scene: Reference
export(bool) var spawn_on_ready = true
export(bool) var keep_loaded # load the scene at ready and keep it loaded
var game_state: Node

func _ready():
	var game_state_path = Helpers.get_root_path_of(self)
	game_state = get_node(game_state_path)

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
		game_state.get_node("Entities").add_child(spawned_node)
		spawned_node.position = position

	return spawned_node
