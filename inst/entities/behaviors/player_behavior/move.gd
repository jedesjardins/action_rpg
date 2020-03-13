extends BTNode

func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("physics_body"))
	assert(blackboard.has("velocity"))
	assert(blackboard.has("direction"))
	
	var physics_body = blackboard.physics_body
	var animation_player = physics_body.get_node("AnimationPlayer")
	
	var velocity = blackboard.velocity
	var direction = blackboard.direction
	
	if velocity.length() > 0:
		var next_animation = "walk_" + blackboard.direction_string[direction]
		
		if not animation_player.current_animation == next_animation:
			animation_player.advance(0)
			animation_player.play(next_animation)
	
	physics_body.move_and_slide(velocity)
	
	var z = physics_body.get_global_transform_with_canvas().get_origin().y

	physics_body.get_node("Sprite").z_index = z
	
	if blackboard.has("item"):
		blackboard.item.set_direction(direction)
		var modifier = 0
		if direction < 4:
			modifier = 1
		else:
			modifier = -1
		blackboard.item.z_index = z + modifier
	
	return OK
