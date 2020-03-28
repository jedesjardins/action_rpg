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

# Returns FAILED if the player isn't going to move
func tick(blackboard: Dictionary) -> int:
	blackboard.velocity = get_velocity()
	if blackboard.velocity.length() == 0:
		return FAILED
	
	return OK
