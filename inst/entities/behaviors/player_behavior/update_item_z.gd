extends BTNode

# always returns OK since it's passive
func tick(blackboard: Dictionary) -> int:

	assert(blackboard.has("entity"))

	if blackboard.has("item"):
		var z = blackboard.entity.get_global_transform_with_canvas().get_origin().y
		
		blackboard.item.sprite.z_index = z + blackboard.entity.hand.z_modifier

	return OK
