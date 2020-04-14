extends BTNode

func tick(blackboard: Dictionary) -> int:

	blackboard.direction = int(floor(randf() * 8))

	return OK
