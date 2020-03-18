extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("animation_chain"))
	
	if bb.animation_chain.is_playing:
		return OK
	else:
		return FAILED
