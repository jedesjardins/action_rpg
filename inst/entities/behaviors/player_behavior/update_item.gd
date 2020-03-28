extends BTNode

# always returns OK since it's passive
func tick(blackboard: Dictionary) -> int:
	
	assert(blackboard.has("entity"))
	assert(blackboard.has("direction"))
	
	if blackboard.has("item"):
		blackboard.item.set_direction(blackboard.direction)
		var z = blackboard.entity.get_global_transform_with_canvas().get_origin().y

		if blackboard.direction < 4:
			blackboard.item.z_index = z + 1
		else:
			blackboard.item.z_index = z - 1

	return OK
