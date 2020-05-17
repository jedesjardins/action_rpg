extends BTNode

export var value: bool

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.entity.has_node("Health"))
	var health = bb.entity.get_node("Health")

	health.damaged = value

	return OK
