extends Node

class_name TriggerScript

var ignored_node: Node

func _ready():
	pass

func trigger_entered(body):
	if body != ignored_node:
		print("Base trigger_entered called")

func trigger_exited(body):
	if body != ignored_node:
		print("Base trigger_exited called")

func set_ignore(node: Node):
	ignored_node = node
