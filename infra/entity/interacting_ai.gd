extends BaseBehavior

class_name InteractingAIBehavior

export var ai_script_path: NodePath
export var interact_script_path: NodePath
var ai_script: Node
var interact_script: Node

func _ready():
	ai_script = get_node(ai_script_path)
	ai_script.set_physics_body(get_physics_body())
	interact_script = get_node(interact_script_path)
	
	var interaction_trigger = get_physics_body().get_trigger()
	interaction_trigger.set_ignore(get_physics_body())
	interaction_trigger.connect("body_entered", interact_script, "trigger_entered")
	interaction_trigger.connect("body_exited", interact_script, "trigger_exited")
