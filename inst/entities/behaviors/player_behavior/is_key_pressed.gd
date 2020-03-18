extends BTNode

export var scancode_string: String
onready var scancode = OS.find_scancode_from_string(scancode_string)

func tick(_bb: Dictionary) -> int:
	if Input.is_key_pressed(scancode):
		return OK
	else:
		return FAILED
