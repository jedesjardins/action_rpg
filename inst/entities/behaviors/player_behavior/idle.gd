extends BTNode

# always returns OK since it's passive
func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("entity"))
	assert(blackboard.has("direction"))
	assert(blackboard.has("direction_string"))
	
	var direction = blackboard.direction
	
	var animation_player = blackboard.entity.get_node("AnimationPlayer")
	var next_animation = "idle_" + blackboard.direction_string[direction]
	if next_animation != animation_player.current_animation:
		animation_player.play(next_animation)
	
	var z = blackboard.entity.get_global_transform_with_canvas().get_origin().y
	
	blackboard.entity.get_node("Sprite").z_index = z
	
	return OK
