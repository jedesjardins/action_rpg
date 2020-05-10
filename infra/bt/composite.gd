tool

class_name Composite
extends BTNode

func _ready():
	assert(get_child_count() > 0)

func _get_configuration_warning():
	if get_child_count() == 0:
		return "Composite Nodes must have at least one child"

	for child in get_children():
		if not child is BTNode:
			return "Composite Nodes children must be BTNodes"

	return ""
