extends Node2D

# to be used under a behavior node of an entity.
class_name TriggerScript

var trigger_node: Area2D
var ignored_node: Node

# called when the trigger is entered
func on_Trigger_body_entered(body):
	if body != ignored_node:
		print("Base trigger_entered called")

# called when the trigger is exited
func on_Trigger_body_exited(body):
	if body != ignored_node:
		print("Base trigger_exited called")

func set_trigger(node: Area2D):
	if trigger_node:
		trigger_node.disconnect("body_entered", self, "on_Trigger_body_entered")
		trigger_node.disconnect("body_exited", self, "on_Trigger_body_exited")

	if node:
		var _err = node.connect("body_entered", self, "on_Trigger_body_entered")
		_err = node.connect("body_exited", self, "on_Trigger_body_entered")

func set_ignore(node: Node):
	ignored_node = node
