extends BTNode

export var value: bool

func tick(bb: Dictionary) -> int:
	bb.is_charging = value
	
	return OK
