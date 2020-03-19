extends BTNode

func get_velocity():
	var velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1

	velocity = velocity.normalized() * Helpers.get_walk_speed()

	return velocity

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
			return Helpers.Direction.DOWN_LEFT
		elif velocity.x > 0:
			return Helpers.Direction.DOWN_RIGHT
		else:
			return blackboard.direction

# Returns FAILED if the player isn't going to move
func tick(blackboard: Dictionary) -> int:
	blackboard.velocity = get_velocity()
	if blackboard.velocity.length() == 0:
		return FAILED

	blackboard.direction = get_direction(blackboard)
	
	return OK
