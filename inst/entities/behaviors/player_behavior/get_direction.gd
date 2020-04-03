extends BTNode

func get_direction(blackboard):
	var velocity = blackboard.velocity
	if velocity.y < 0:
		if velocity.x < 0:
			return Helpers.Direction.UP_LEFT
		elif velocity.x > 0:
			return Helpers.Direction.UP_RIGHT
		else:
			return Helpers.Direction.UP
	elif velocity.y > 0:
		if velocity.x < 0:
			return Helpers.Direction.DOWN_LEFT
		elif velocity.x > 0:
			return Helpers.Direction.DOWN_RIGHT
		else:
			return Helpers.Direction.DOWN
	else:
		if velocity.x < 0:
			return Helpers.Direction.LEFT
		elif velocity.x > 0:
			return Helpers.Direction.RIGHT
		else:
			return blackboard.direction

# Returns FAILED if the player isn't going to move
func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("velocity"))
	
	blackboard.direction = get_direction(blackboard)
	
	return OK
