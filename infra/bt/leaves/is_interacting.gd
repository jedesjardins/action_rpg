extends BTNode

func tick(blackboard: Dictionary) -> int:
	assert(blackboard.interact_script)

	if blackboard.interact_script.is_interacting():
		return OK
	else:
		return FAILED
