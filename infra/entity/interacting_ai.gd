tool
extends BaseBehavior

class_name InteractingAIBehavior

export var ai_script_path: NodePath
export var interact_script_path: NodePath
var ai_script: BehaviorTree
var interact_script: Node

var blackboard: Dictionary

func _ready():
	#ai_script = get_node(ai_script_path)
	#ai_script.set_physics_body(get_physics_body())
	interact_script = get_node(interact_script_path)
	blackboard.interact_script = interact_script
	blackboard.direction_string = {
		Helpers.Direction.DOWN: "down",
		Helpers.Direction.DOWN_RIGHT: "down_right",
		Helpers.Direction.RIGHT: "down_right",
		Helpers.Direction.UP_RIGHT: "up_right",
		Helpers.Direction.UP: "up",
		Helpers.Direction.UP_LEFT: "up_left",
		Helpers.Direction.LEFT: "down_left",
		Helpers.Direction.DOWN_LEFT: "down_left"
	}
	blackboard.direction = Helpers.Direction.DOWN

func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	
	blackboard.delta = delta
	
	$"BehaviorTree".tick(blackboard)

func set_physics_body(physics_body: BasePhysicsBody):
	.set_physics_body(physics_body) # call inherited function
	blackboard.physics_body = physics_body
	
	var interaction_trigger = physics_body.get_trigger()
	interact_script.set_ignore(physics_body)
	interact_script.set_trigger(interaction_trigger)

func _get_configuration_warning():
#	if not ai_script_path:
#		return "Check later"

	if not interact_script_path:
		return "InteractingAIBehavior needs the interact_script_path to be specified"

	return ""
