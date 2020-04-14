extends BTNode

func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("direction"))
	assert(blackboard.has("direction_string"))
	assert(blackboard.has("entity"))

	var direction = blackboard.direction

	blackboard.entity.get_node("AnimationPlayer").play("idle_"+blackboard.direction_string[direction])

	return OK
