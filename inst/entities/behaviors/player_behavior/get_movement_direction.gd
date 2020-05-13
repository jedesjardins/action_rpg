extends BTNode

func get_direction(blackboard):
	var velocity = blackboard.velocity
	if velocity.y < 0:
		if velocity.x < 0:
			return Global.Direction.UP_LEFT
		elif velocity.x > 0:
			return Global.Direction.UP_RIGHT
		else:
			return Global.Direction.UP
	elif velocity.y > 0:
		if velocity.x < 0:
			return Global.Direction.DOWN_LEFT
		elif velocity.x > 0:
			return Global.Direction.DOWN_RIGHT
		else:
			return Global.Direction.DOWN
	else:
		if velocity.x < 0:
			return Global.Direction.LEFT
		elif velocity.x > 0:
			return Global.Direction.RIGHT
		else:
			return blackboard.direction

# Returns FAILED if the player isn't going to move
func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("velocity"))

	blackboard.direction = get_direction(blackboard)

	return OK
