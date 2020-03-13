extends BTNode

export var time: float

func tick(blackboard: Dictionary) -> int:
	blackboard.timer = time
	
	return OK
