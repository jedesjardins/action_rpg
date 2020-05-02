extends BTNode

#func get_direction(blackboard):
#	var velocity = blackboard.velocity
#	if velocity.y < 0:
#		if velocity.x < 0:
#			return Helpers.Direction.UP_LEFT
#		elif velocity.x > 0:
#			return Helpers.Direction.UP_RIGHT
#		else:
#			return Helpers.Direction.UP
#	elif velocity.y > 0:
#		if velocity.x < 0:
#			return Helpers.Direction.DOWN_LEFT
#		elif velocity.x > 0:
#			return Helpers.Direction.DOWN_RIGHT
#		else:
#			return Helpers.Direction.DOWN
#	else:
#		if velocity.x < 0:
#			return Helpers.Direction.LEFT
#		elif velocity.x > 0:
#			return Helpers.Direction.RIGHT
#		else:
#			return blackboard.direction

func get_direction(bb):
	var mouse_position = get_viewport().get_mouse_position()
	mouse_position = $"/root/Node2D".transform_position(mouse_position)
	mouse_position = get_viewport().canvas_transform.affine_inverse().xform(mouse_position)

	var e_to_m_vec = (mouse_position - bb.entity.global_position).normalized()

	# Vector2(0, 1) maps to 0 radians, counter clockwise is positive
	var angle_to_mouse = (((Vector2(0, -1).angle_to(e_to_m_vec) * -1) + PI) / (2 * PI))
	var direction = int(floor(fmod((angle_to_mouse * 8 ) + .5, 8)))

	# print("Direction: ", direction, ", Angle to Mouse: ", angle_to_mouse, ", mouse vector: ", e_to_m_vec)

	return direction

# Returns FAILED if the player isn't going to move
func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("entity"))

	blackboard.direction = get_direction(blackboard)

	return OK
