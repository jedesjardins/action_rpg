extends BTNode

func tick(bb: Dictionary) -> int:
	if bb.has("item"):
		return OK
	
	return FAILED
