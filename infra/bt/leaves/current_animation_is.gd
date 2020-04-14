extends BTNode

export var animation: String

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))

	if bb.entity.get_node("AnimationPlayer").current_animation == animation:
		print("Animation matches")
		return OK

	print("Animation doesn't match")
	return FAILED
