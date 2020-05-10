tool

class_name BehaviorTree
extends BTNode

func _ready():
	assert(get_child_count() == 1)

func tick(blackboard: Dictionary) -> int:
	assert(get_child_count() == 1)

	return get_children()[0].tick(blackboard)

func _get_configuration_warning():
	if get_child_count() != 1:
		return "Behavior Trees must have exactly one child"

	if not get_children()[0] is BTNode:
		return "Behavior Trees child must be a BTNode"

	return ""
