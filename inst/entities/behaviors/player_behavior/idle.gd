extends BTNode

# always returns OK since it's passive
func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("physics_body"))
	assert(blackboard.has("direction"))
	assert(blackboard.has("direction_string"))
	
	var direction = blackboard.direction
	
	var animation_player = blackboard.physics_body.get_node("AnimationPlayer")
	var next_animation = "idle_" + blackboard.direction_string[direction]
	if next_animation != animation_player.current_animation:
		animation_player.play(next_animation)
	
	if blackboard.has("item"):
		blackboard.item.set_direction(direction)
		var z = blackboard.physics_body.get_global_transform_with_canvas().get_origin().y

		if direction < 4:
			blackboard.item.z_index = z + 1
		else:
			blackboard.item.z_index = z - 2 #?????

	return OK
