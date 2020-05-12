extends BTNode

var can_interact = true

func enable_interaction_after(script, entity, interactor):
	interactor.can_interact = false
	var result = script.interact(entity)
	if result is GDScriptFunctionState:
		yield(result, "completed")
	interactor.can_interact = true

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.entity.has_node("Interact"))
	var interactor = bb.entity.get_node("Interact")

	if Input.is_action_just_pressed("interact") and interactor.can_interact and interactor.next_interact_script:
		enable_interaction_after(interactor.next_interact_script, bb.entity, interactor)

	return OK
