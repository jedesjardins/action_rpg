
extends BehaviorTree

func _ready():
	blackboard.direction = Global.Direction.DOWN
	blackboard.direction_string = {
		Global.Direction.DOWN: "down",
		Global.Direction.DOWN_RIGHT: "right",
		Global.Direction.RIGHT: "right",
		Global.Direction.UP_RIGHT: "right",
		Global.Direction.UP: "up",
		Global.Direction.UP_LEFT: "left",
		Global.Direction.LEFT: "left",
		Global.Direction.DOWN_LEFT: "left"
	}
