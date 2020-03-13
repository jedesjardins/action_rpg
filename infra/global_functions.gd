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
	return 36

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
