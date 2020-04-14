extends BTNode

func tick(bb: Dictionary) -> int:
	if bb.current_attack.has("next_attack"):
		if bb.current_attack.next_attack == "":
			print("Current Attacks \"next_attack\" field is blank")
		bb.next_attack = bb.current_attack.next_attack

	return OK
