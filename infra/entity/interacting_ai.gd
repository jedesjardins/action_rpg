tool

class_name InteractingAIBehavior
extends BaseBehavior

export var ai_script_path: NodePath
export var interact_script_path: NodePath
var ai_script: BehaviorTree
var interact_script: Node

var blackboard: Dictionary

func _ready():
	#ai_script = get_node(ai_script_path)
	#ai_script.set_entity(get_entity())
	interact_script = get_node(interact_script_path)
	blackboard.interact_script = interact_script
	blackboard.direction_string = {
		Global.Direction.DOWN: "down",
		Global.Direction.DOWN_RIGHT: "down_right",
		Global.Direction.RIGHT: "down_right",
		Global.Direction.UP_RIGHT: "up_right",
		Global.Direction.UP: "up",
		Global.Direction.UP_LEFT: "up_left",
		Global.Direction.LEFT: "down_left",
		Global.Direction.DOWN_LEFT: "down_left"
	}
	blackboard.direction = Global.Direction.DOWN

func _physics_process(delta):
	if Engine.is_editor_hint():
		return

	blackboard.delta = delta

	$"BehaviorTree".tick(blackboard)

func set_entity(node: Node):
	if entity != null:
		entity.hurtbox.disconnect("area_entered", self, "on_Hurtbox_area_entered")

	.set_entity(node) # call inherited function
	blackboard.entity = node

	interact_script.set_ignore(entity)
	interact_script.set_trigger(entity.get_trigger())
	var _err = entity.hurtbox.connect("area_entered", self, "on_Hurtbox_area_entered")

func _get_configuration_warning():
#	if not ai_script_path:
#		return "Check later"

	if not interact_script_path:
		return "InteractingAIBehavior needs the interact_script_path to be specified"

	return ""

func on_Hurtbox_area_entered(_area):
	entity.sprite.flash()
