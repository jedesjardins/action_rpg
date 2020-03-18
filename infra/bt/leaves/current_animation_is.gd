extends BTNode

export var animation: String

func tick(bb: Dictionary) -> int:
	assert(bb.has("physics_body"))
	
	if bb.physics_body.get_node("AnimationPlayer").current_animation == animation:
		return OK
	
	return FAILED
