
extends BehaviorTree

func _ready():
	blackboard.direction = Helpers.Direction.DOWN
	blackboard.direction_string = {
		Helpers.Direction.DOWN: "down",
		Helpers.Direction.DOWN_RIGHT: "right",
		Helpers.Direction.RIGHT: "right",
		Helpers.Direction.UP_RIGHT: "right",
		Helpers.Direction.UP: "up",
		Helpers.Direction.UP_LEFT: "left",
		Helpers.Direction.LEFT: "left",
		Helpers.Direction.DOWN_LEFT: "left"
	}
