extends BTNode

# always returns OK since it's passive
func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("direction"))

	if blackboard.has("item"):
		var ap = blackboard.item.get_children()[0].get_node("AnimationPlayer")
		ap.play("held_" + blackboard.direction_string[blackboard.direction])

	return OK
