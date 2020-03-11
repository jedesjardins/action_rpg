tool
extends TriggerScript

class_name InteractScript

func _ready():
	pass

func interact():
	print("Base interact called")

func trigger_entered(body):
	if body.is_in_group("player") and body != ignored_node:
		print("InteractScript trigger_entered called")

func trigger_exited(body):
	if body.is_in_group("player") and body != ignored_node:
		print("InteractScript trigger_exited called")
