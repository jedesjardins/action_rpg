extends Node

class_name Helpers

enum Direction {
	DOWN,
	DOWN_RIGHT,
	RIGHT,
	UP_RIGHT,
	UP,
	UP_LEFT,
	LEFT,
	DOWN_LEFT
}

static func get_walk_speed():
	return 90

static func get_relative_path_from(start: Node, end: Node) -> String:
	#var start_path_length = start.get_
	pass

	var start_path = start.get_path()
	var start_path_size = start_path.get_name_count()
	var end_path = end.get_path()
	var end_path_size = end_path.get_name_count()

	# find their common parent
	var overlapping_path_size = min(start_path_size, end_path_size)

	# find how many levels lower start is from the parent
	var greatest_common_depth = 0
	for i in overlapping_path_size:
		if start_path.get_name(i) != end_path.get_name(i):
			greatest_common_depth = i
			break

	# concatenate ../ for every level lower the start node is
	var path = "../".repeat(start_path_size - greatest_common_depth)

	# concatenate the node path to the end from the common parent, down
	for i in (end_path_size - greatest_common_depth):
		path += end_path.get_name(greatest_common_depth + i)

	return path

static func run_animation_chain(animation_player, anim_list: Array, anim_durations = null):
	assert(anim_list.size() > 0)

	# if anim_durations == null, create one
	if not anim_durations:
		anim_durations = []

	# resize and fill the nil values in the array
	if anim_durations.size() != anim_list.size():
		var starting_size = anim_durations.size()
		anim_durations.resize(anim_list.size())
		
		for i in range(anim_list.size() - starting_size):
			anim_durations[i+starting_size] = 1

	if animation_player.current_animation == anim_list[0]:
		animation_player.seek(0, true)

	for i in range(anim_list.size()):
		var animation_name = anim_list[i]
		
		animation_player.play(animation_name, -1, anim_durations[i])
		
		yield(animation_player, "animation_finished")
		
		print("Animation_Player current: ", animation_player.current_animation, " expected: ", animation_name)

static func play_animation_duration(ap: AnimationPlayer, animation_name: String, duration: float):
	var time_scale = ap.get_animation(animation_name).length / duration

	ap.play(animation_name, -1, time_scale)
	ap.advance(0)
