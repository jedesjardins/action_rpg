extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity_animation_chain"))
	
	if bb.entity_animation_chain.is_playing:
		return OK
	else:
		return FAILED
