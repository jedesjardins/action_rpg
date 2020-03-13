extends BTNode

func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("direction"))
	assert(blackboard.has("direction_string"))
	assert(blackboard.has("physics_body"))
	
	var direction = blackboard.direction
	
	blackboard.physics_body.get_node("AnimationPlayer").play("idle_"+blackboard.direction_string[direction])
	
	return OK
