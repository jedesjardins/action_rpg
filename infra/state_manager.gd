
class_name StateManager
extends Node2D

onready var state_pause_stack = [false]

func get_last_child() -> Node:
	var child_count = get_child_count()

	if get_child_count() == 0:
		return null

	return get_children()[child_count-1]

func push_scene(scene, pause_flag = false):
	add_child(scene)
	state_pause_stack.append(pause_flag)

	if pause_flag:
		recalculate_pause_state()

func pop_scene():
	var current_scene = get_last_child()

	if current_scene:
		remove_child(current_scene)
		current_scene.queue_free()
		state_pause_stack.pop_back()
	
	recalculate_pause_state()

func swap_scene(next_scene, pause_flag = false):
	var current_scene = get_last_child()

	if current_scene:
		remove_child(current_scene)
		current_scene.queue_free()

	add_child(next_scene)
	state_pause_stack.pop_back()
	state_pause_stack.append(pause_flag)

	recalculate_pause_state()

func recalculate_pause_state():
	var child_count = get_child_count()
	assert(child_count == state_pause_stack.size())

	var pause_flag = false
	for i in range(child_count-1, -1, -1):
		var child = get_children()[i]
		var next_pause_flag = state_pause_stack[i]

		if pause_flag:
			child.pause_mode = PAUSE_MODE_STOP
		else:
			child.pause_mode = PAUSE_MODE_PROCESS

		pause_flag = pause_flag or next_pause_flag

	if pause_flag:
		get_tree().paused = true
	else:
		get_tree().paused = false
