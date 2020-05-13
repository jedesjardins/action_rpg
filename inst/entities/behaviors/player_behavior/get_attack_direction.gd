extends BTNode

func get_direction(bb):
	var mouse_position = Global.get_viewport_mouse_position(bb.entity.get_viewport())
	var angle_to_mouse = Global.get_angle_to_pos_from(mouse_position, bb.entity)
	var direction = int(floor(fmod((angle_to_mouse * 8 ) + .5, 8)))

	return direction

# Returns FAILED if the player isn't going to move
func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("entity"))

	blackboard.direction = get_direction(blackboard)

	return OK
