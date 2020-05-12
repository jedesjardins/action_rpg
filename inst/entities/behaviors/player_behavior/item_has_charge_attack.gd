extends BTNode

func tick(blackboard: Dictionary) -> int:	
	if not blackboard.item.get_node("Hitbox").attack_info.get_charge_attack():
		return FAILED

	return OK
