extends BTNode

# always returns OK since it's passive
func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("physics_body"))
	assert(blackboard.has("direction"))
	
	blackboard.physics_body.get_node("AnimationPlayer").play("stand")
	
	if blackboard.has("item"):
		blackboard.item.set_direction(Helpers.Direction.DOWN)
		var z = blackboard.physics_body.get_global_transform_with_canvas().get_origin().y
		blackboard.item.z_index = z + 1
	
	return OK
