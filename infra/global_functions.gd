
class_name Helpers
extends Node

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

static func get_relative_path_from(start: Node, end: Node) -> String:
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
		path += end_path.get_name(greatest_common_depth + i) + "/"

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

static func get_root_path_of(node: Node) -> NodePath:
	var node_path = node.get_path()
	# There should be at least /root/Node2d/Viewport/StateManager/RootState
	assert(node_path.get_name_count() >= 5)

	var root_path = "/"
	for i in range(0, 5):
		root_path += node_path.get_name(i) + "/"

	return root_path

static func get_zone_path_of(node: Node) -> NodePath:
	var node_path = node.get_path()
	# There should be at least /root/Node2d/Viewport/StateManager/RootState/Zones/Zone
	assert(node_path.get_name_count() >= 7)

	var zone_path = "/"
	for i in range(0, 7):
		zone_path += node_path.get_name(i) + "/"

	return zone_path

static func swap_and_pop_back(array: Array, element):
	var index = array.find(element)

	if index != -1:
		if index != array.size() - 1:
			array[index] = array[array.size() - 1]

		array.pop_back()

static func get_viewport_mouse_position(vp):
	var mouse_position = vp.get_mouse_position()
	mouse_position = vp.get_node("/root/Node2D").transform_position(mouse_position)
	mouse_position = vp.canvas_transform.affine_inverse().xform(mouse_position)

	return mouse_position

# returns an angle between 0 - 2*PI where Vector2(0, 1) is 0 radians
static func get_angle_to_pos_from(pos, entity):
	var e_to_p_vec = (pos - entity.global_position).normalized()

	return (((Vector2(0, -1).angle_to(e_to_p_vec) * -1) + PI) / (2 * PI))
