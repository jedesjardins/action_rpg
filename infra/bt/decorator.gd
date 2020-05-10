tool

class_name Decorator
extends BTNode

func _ready():
	assert(get_child_count() == 1)

func _get_configuration_warning():
	if get_child_count() != 1:
		return "Decorator Nodes must have exactly one child"

	if get_children()[0] is BTNode:
			return "A Decorator Nodes child must be a BTNode"

	return ""
