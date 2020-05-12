extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.entity.has_node("Health"))
	var health = bb.entity.get_node("Health")
	if health.damaged == true:
		return OK

	return FAILED
