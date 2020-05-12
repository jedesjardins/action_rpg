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

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.has("direction"))

	bb.velocity = get_velocity(bb.direction) * bb.entity.configuration.walk_speed

	return OK
