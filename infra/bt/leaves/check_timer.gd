extends BTNode

func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("timer"))

	if blackboard.timer > 0:
		blackboard.timer -= blackboard.delta
		return OK

	return FAILED
