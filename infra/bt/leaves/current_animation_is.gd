extends BTNode

export var animation: String

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))

	if bb.entity.get_node("AnimationPlayer").current_animation == animation:
		return OK

	return FAILED
