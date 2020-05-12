tool

class_name BehaviorTree
extends BTNode

onready var blackboard = {}

func _ready():
	assert(get_child_count() == 1)
	blackboard.entity = get_parent()

func _physics_process(delta):
	if Engine.is_editor_hint():
		return

	blackboard.delta = delta

	get_children()[0].tick(blackboard)

func _get_configuration_warning():
	if get_child_count() != 1:
		return "Behavior Trees must have exactly one child"

	if not get_children()[0] is BTNode:
		return "Behavior Trees child must be a BTNode"

	return ""
