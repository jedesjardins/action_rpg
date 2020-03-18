extends BTNode

export var action: String

func tick(_bb: Dictionary) -> int:
	if Input.is_action_just_pressed(action):
		return OK
	else:
		return FAILED
