extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.has("target"))

	var vec_to_target = bb.target.global_position - bb.entity.global_position

	if vec_to_target.length() < 100:
		return OK

	return FAILED
