extends BTNode

func get_direction(bb):
	var angle_to_mouse = Helpers.get_angle_to_mouse_from(bb.entity)
	var direction = int(floor(fmod((angle_to_mouse * 8 ) + .5, 8)))

	return direction

# Returns FAILED if the player isn't going to move
func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("entity"))

	blackboard.direction = get_direction(blackboard)

	return OK
