extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.entity.has_node("Interact"))
	var interactor = bb.entity.get_node("Interact")

	if Input.is_action_just_pressed("interact"):
		interactor.interact()

	return OK
