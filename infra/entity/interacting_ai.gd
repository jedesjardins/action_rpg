tool
extends BaseBehavior

class_name InteractingAIBehavior

export var ai_script_path: NodePath
export var interact_script_path: NodePath
var ai_script: Node
var interact_script: Node

func _ready():
#	ai_script = get_node(ai_script_path)
#	ai_script.set_physics_body(get_physics_body())
	interact_script = get_node(interact_script_path)

func set_physics_body(physics_body: BasePhysicsBody):
	var old_physics_body = get_physics_body()
	if old_physics_body != null:
		var interaction_trigger = old_physics_body.get_trigger()
		interaction_trigger.remove_ignore(old_physics_body)
		interaction_trigger.disconnect("body_entered", interact_script, "trigger_entered")
		interaction_trigger.disconnect("body_exited", interact_script, "trigger_exited")

	.set_physics_body(physics_body) # call inherited function
	
	var interaction_trigger = physics_body.get_trigger()
	interact_script.set_ignore(physics_body)
	interaction_trigger.connect("body_entered", interact_script, "trigger_entered")
	interaction_trigger.connect("body_exited", interact_script, "trigger_exited")

func _get_configuration_warning():
#	if not ai_script_path:
#		return "Check later"

	if not interact_script_path:
		return "InteractingAIBehavior needs the interact_script_path to be specified"

	return ""
