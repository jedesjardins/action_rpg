extends BTNode

# always returns OK since it's passive
func tick(blackboard: Dictionary) -> int:
	
	assert(blackboard.has("entity"))
	
	if blackboard.has("item"):
		var z = blackboard.entity.get_global_transform_with_canvas().get_origin().y

		if blackboard.direction < 4:
			blackboard.item.z_index = z + 1
		else:
			blackboard.item.z_index = z - 1

	return OK
