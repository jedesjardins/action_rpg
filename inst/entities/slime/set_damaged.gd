extends BTNode

export var value: bool

func tick(bb: Dictionary) -> int:
	assert(bb.has("damaged"))

	bb.damaged = value

	return OK
