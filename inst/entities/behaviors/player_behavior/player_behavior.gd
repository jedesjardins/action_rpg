
tool
extends BaseBehavior

var blackboard: Dictionary

var interact_map: Dictionary
var next_interact_script: Node

func _ready():
	blackboard.direction = Helpers.Direction.DOWN
	blackboard.direction_string = {
		Helpers.Direction.DOWN: "down",
		Helpers.Direction.DOWN_RIGHT: "down_right",
		Helpers.Direction.RIGHT: "up_right",
		Helpers.Direction.UP_RIGHT: "up_right",
		Helpers.Direction.UP: "up",
		Helpers.Direction.UP_LEFT: "up_left",
		Helpers.Direction.LEFT: "down_left",
		Helpers.Direction.DOWN_LEFT: "down_left"
	}

	blackboard.interacting = false
	blackboard.interact_map = interact_map
	blackboard.interactor = self

func set_entity(node: Node):
	.set_entity(node) # call inherited function
	blackboard.entity = node

func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	
	blackboard.delta = delta
	blackboard.next_interact_script = next_interact_script
	
	if Input.is_key_pressed(KEY_Q):
		entity.drop_item()
	
	$"BehaviorTree".tick(blackboard)

func add_interact_script(script):
	interact_map[script] = true
	next_interact_script = script

func remove_interact_script(script):
	var _script_existed = interact_map.erase(script)
	if next_interact_script == script:
		if interact_map.keys().size() > 0:
			next_interact_script = interact_map.keys()[0]
		else:
			next_interact_script = null
