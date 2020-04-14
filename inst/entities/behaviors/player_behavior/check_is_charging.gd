extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("is_charging"))

	if bb.is_charging == true:
		return OK

	return FAILED
