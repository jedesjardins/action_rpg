extends BTNode

var can_interact = true

func enable_interaction_after(script):
	can_interact = false
	var result = script.interact()
	if result is GDScriptFunctionState:
		yield(result, "completed")
	can_interact = true

func tick(blackboard: Dictionary) -> int:
	if can_interact and Input.is_action_just_pressed("ui_accept") and blackboard.next_interact_script:
		enable_interaction_after(blackboard.next_interact_script)
	
	return OK
