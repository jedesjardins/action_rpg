extends BTNode

# always returns OK since it's passive
func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("direction"))
	
	if blackboard.has("item"):
		blackboard.item.set_direction(blackboard.direction)

	return OK
