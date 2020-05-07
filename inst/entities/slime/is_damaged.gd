extends BTNode

func tick(bb: Dictionary) -> int:
	if bb.has("damaged") and bb.damaged == true:
		return OK

	return FAILED
