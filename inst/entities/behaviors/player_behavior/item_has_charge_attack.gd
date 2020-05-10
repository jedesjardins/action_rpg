extends BTNode

func tick(blackboard: Dictionary) -> int:	
	if not blackboard.item.attack_info.get_charge_attack():
		return FAILED

	return OK
