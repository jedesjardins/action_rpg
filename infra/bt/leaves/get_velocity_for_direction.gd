extends BTNode

onready var leftover_delta_velocity = Vector2(0, 0)

func get_velocity(direction: int):
	match direction:
		Helpers.Direction.DOWN:
			return Vector2(0, 1)
		Helpers.Direction.DOWN_RIGHT:
			return Vector2(1, 1).normalized()
		Helpers.Direction.RIGHT:
			return Vector2(1, 0)
		Helpers.Direction.UP_RIGHT:
			return Vector2(1, -1).normalized()
		Helpers.Direction.UP:
			return Vector2(0, -1)
		Helpers.Direction.UP_LEFT:
			return Vector2(-1, -1).normalized()
		Helpers.Direction.LEFT:
			return Vector2(-1, 0)
		Helpers.Direction.DOWN_LEFT:
			return Vector2(-1, 1).normalized()

func tick(blackboard: Dictionary) -> int:
	assert(blackboard.has("physics_body"))
	assert(blackboard.has("direction"))
	
	var physics_body = blackboard.physics_body
	var animation_player = physics_body.get_node("AnimationPlayer")
	
	var direction = blackboard.direction
	
	var next_animation = "walk_" + blackboard.direction_string[direction]
	
	if not animation_player.current_animation == next_animation:
		animation_player.advance(0)
		animation_player.play(next_animation)
	
	blackboard.velocity = get_velocity(direction) * Helpers.get_walk_speed()
	
	return OK
