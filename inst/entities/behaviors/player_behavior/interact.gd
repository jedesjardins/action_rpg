extends BTNode

var can_interact = true

func enable_interaction_after(script, bb):
	can_interact = false
	var result = script.interact(bb.interactor)
	if result is GDScriptFunctionState:
		yield(result, "completed")
	can_interact = true

func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("interactor"))
	
	if can_interact and Input.is_action_just_pressed("interact") and blackboard.next_interact_script:
		enable_interaction_after(blackboard.next_interact_script, blackboard)
	
	return OK
