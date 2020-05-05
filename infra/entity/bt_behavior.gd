extends BaseBehavior

export var behavior_tree_path: NodePath

onready var behavior_tree = get_node(behavior_tree_path)
onready var blackboard = {
	"direction": Helpers.Direction.DOWN,
	"direction_string": {
		Helpers.Direction.DOWN: "down",
		Helpers.Direction.DOWN_RIGHT: "right",
		Helpers.Direction.RIGHT: "right",
		Helpers.Direction.UP_RIGHT: "right",
		Helpers.Direction.UP: "up",
		Helpers.Direction.UP_LEFT: "left",
		Helpers.Direction.LEFT: "left",
		Helpers.Direction.DOWN_LEFT: "left"
	}
}

func set_entity(node: Node):
	.set_entity(node) # call inherited function, sets entity
	blackboard.entity = entity

func _physics_process(delta):
	blackboard.delta = delta

	$"BehaviorTree".tick(blackboard)
