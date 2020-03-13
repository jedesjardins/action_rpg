extends BTNode

onready var leftover_delta_velocity = Vector2(0, 0)

func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("physics_body"))
	assert(blackboard.has("velocity"))
	assert(blackboard.has("direction"))
	
	var physics_body = blackboard.physics_body
	var animation_player = physics_body.get_node("AnimationPlayer")
	
	var velocity = blackboard.velocity
	
	#velocity += leftover_velocity
	
	#leftover_velocity = velocity - velocity.floor()
	
	#velocity = velocity.floor()
	
	#print("Starting Position: ", physics_body.get_global_transform_with_canvas().get_origin())
	
	#print("Velocity: ", velocity)
	
	var direction = blackboard.direction
	
	if velocity.length() > 0:
		var next_animation = "walk_" + blackboard.direction_string[direction]
		
		if not animation_player.current_animation == next_animation:
			animation_player.advance(0)
			animation_player.play(next_animation)
	
	var delta_velocity = velocity * blackboard.delta

	delta_velocity += leftover_delta_velocity
	
	leftover_delta_velocity = delta_velocity - delta_velocity.floor()
	
	delta_velocity = delta_velocity.floor()
	
	physics_body.move_and_collide(delta_velocity)
	
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
	
	#print("Ending Position: ", physics_body.get_global_transform_with_canvas().get_origin())
	
	return OK
