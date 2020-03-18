
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

func set_physics_body(physics_body: BasePhysicsBody):
	.set_physics_body(physics_body) # call inherited function
	blackboard.physics_body = physics_body

func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	
	blackboard.delta = delta
	blackboard.next_interact_script = next_interact_script
	
	$"BehaviorTree".tick(blackboard)

func hold_item(var item_node: HeldItem):
	if physics_body.has_node("Hand"):

		var hand = physics_body.get_node("Hand")

		if hand.has_node("item_transform"):
			hand.get_node("item_transform").queue_free()

		if item_node:
			blackboard.item = item_node
			var remote_transform = RemoteTransform2D.new()
			remote_transform.name = "item_transform"
			hand.add_child(remote_transform, true)
			remote_transform.remote_path = Helpers.get_relative_path_from(remote_transform, item_node)

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
