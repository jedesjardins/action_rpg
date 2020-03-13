extends BTNode

# always returns OK since it's passive
func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("physics_body"))
	assert(blackboard.has("direction"))
	assert(blackboard.has("direction_string"))
	
	var direction = blackboard.direction
	
	blackboard.physics_body.get_node("AnimationPlayer").play("idle_" + blackboard.direction_string[direction])
	
	if blackboard.has("item"):
		blackboard.item.set_direction(direction)
		var z = blackboard.physics_body.get_global_transform_with_canvas().get_origin().y

		if direction < 4:
			blackboard.item.z_index = z + 1
		else:
			blackboard.item.z_index = z - 2 #?????

	return OK
