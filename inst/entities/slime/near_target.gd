extends BTNode

export var distance: int

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.has("target"))

	var vec_to_target = bb.target.global_position - bb.entity.global_position

	if vec_to_target.length() < distance:
		return OK

	return FAILED
