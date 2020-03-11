extends Node

# to be used under a behavior node of an entity.
class_name TriggerScript

var trigger_node: Area2D
var ignored_node: Node

# called when the trigger is entered
func trigger_entered(body):
	if body != ignored_node:
		print("Base trigger_entered called")

# called when the trigger is exited
func trigger_exited(body):
	if body != ignored_node:
		print("Base trigger_exited called")

func set_trigger(node: Area2D):
	if trigger_node:
		trigger_node.disconnect("body_entered", self, "trigger_entered")
		trigger_node.disconnect("body_exited", self, "trigger_exited")
	
	if node:
		var err = node.connect("body_entered", self, "trigger_entered")
		if err != OK:
			print("Error ", err)
	
		err = node.connect("body_exited", self, "trigger_exited")
		if err != OK:
			print("Error ", err)

func set_ignore(node: Node):
	ignored_node = node
