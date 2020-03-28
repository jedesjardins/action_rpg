extends BTNode

func tick(blackboard: Dictionary) -> int:	
	if blackboard.item.charge_attack == "":
		return FAILED
	
	return OK
