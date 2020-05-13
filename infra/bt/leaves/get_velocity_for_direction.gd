extends BTNode

onready var leftover_delta_velocity = Vector2(0, 0)

func get_velocity(direction: int):
	match direction:
		Global.Direction.DOWN:
			return Vector2(0, 1)
		Global.Direction.DOWN_RIGHT:
			return Vector2(1, 1).normalized()
		Global.Direction.RIGHT:
			return Vector2(1, 0)
		Global.Direction.UP_RIGHT:
			return Vector2(1, -1).normalized()
		Global.Direction.UP:
			return Vector2(0, -1)
		Global.Direction.UP_LEFT:
			return Vector2(-1, -1).normalized()
		Global.Direction.LEFT:
			return Vector2(-1, 0)
		Global.Direction.DOWN_LEFT:
			return Vector2(-1, 1).normalized()

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.has("direction"))

	bb.velocity = get_velocity(bb.direction) * bb.entity.configuration.walk_speed

	return OK
