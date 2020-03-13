extends BTNode

func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("target_entity"))
	assert(blackboard.has("physics_body"))
	
	var target_physics_body = blackboard.target_entity
	var physics_body = blackboard.physics_body
	
	var difference_vector = target_physics_body.get_global_position() - physics_body.get_global_position()
	
	# get angle from this entity to target entity, where "down" is zero,
	# and counter_clockwise is positive
	var angle = int((rad2deg(Vector2(0, -1).angle_to(difference_vector.normalized()))* -1) + 180 + (45.0/2)) % 360
	
	var direction = int(floor(angle/45))
	
	physics_body.get_node("AnimationPlayer").play("idle_"+blackboard.direction_string[direction])
	
	return OK
