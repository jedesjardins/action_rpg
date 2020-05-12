tool

class_name Entity
extends KinematicBody2D

export var json_path: String
var configuration: Dictionary

func _ready():
	if Engine.is_editor_hint():
		return

	var file = File.new()
	assert(file.file_exists(json_path))
	file.open(json_path, 1)
	var parse_result = JSON.parse(file.get_as_text())
	assert(parse_result.error == OK)

	configuration = parse_result.result

# TODO: move these functions.. but to where?
func animated_move(magnitude: int):
	var mouse_position = Helpers.get_viewport_mouse_position(get_viewport())
	var vector_to_mouse = (mouse_position - self.global_position).normalized()

	animated_move2(vector_to_mouse, magnitude)

func animated_move2(vector: Vector2, magnitude: int):
	var _collision = move_and_collide(vector * magnitude)
