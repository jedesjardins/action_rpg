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
	if entity and entity.has_hurtbox():
		entity.get_hurtbox().disconnect("area_entered", self, "take_damage")

	.set_entity(node) # call inherited function, sets entity
	blackboard.entity = entity

	if entity and entity.has_hurtbox():
		var _err = entity.get_hurtbox().connect("area_entered", self, "take_damage")

func _physics_process(delta):
	blackboard.delta = delta

	$"BehaviorTree".tick(blackboard)

func take_damage(area):
	if area is ChildArea and area.logical_parent != blackboard.get("item") and area.logical_parent != entity:
		blackboard.damaged = true
		blackboard.damaged_by = area.logical_parent
		print("Taken damage from ", area.get_logical_parent().get_path())
