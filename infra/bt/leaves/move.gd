extends BTNode

onready var leftover_delta_velocity = Vector2(0, 0)

func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("entity"))
	assert(blackboard.has("velocity"))
	assert(blackboard.has("direction"))
	
	var entity = blackboard.entity
	var animation_player = entity.get_node("AnimationPlayer")
	
	var velocity = blackboard.velocity
	
	var direction = blackboard.direction
	
	if velocity.length() > 0:
		var next_animation = "walk_" + blackboard.direction_string[direction]
		
		if not animation_player.current_animation == next_animation:
			animation_player.advance(0)
			var time_scale = animation_player.get_animation(next_animation).length / 0.65
			
			animation_player.play(next_animation, -1, time_scale)
	
	var delta_velocity = velocity * blackboard.delta
	
	delta_velocity += leftover_delta_velocity
	
	leftover_delta_velocity = delta_velocity - delta_velocity.floor()
	
	delta_velocity = delta_velocity.floor()
	
	entity.move_and_collide(delta_velocity)
	
	var z = entity.get_global_transform_with_canvas().get_origin().y
	
	entity.get_node("Sprite").z_index = z
	
	return OK
