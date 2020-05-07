extends BTNode


func tick(bb: Dictionary) -> int:
	assert(bb.has("knockback_velocity"))
	assert(bb.has("timer"))

	bb.velocity = bb.knockback_velocity.linear_interpolate(Vector2(0, 0), 1 - (bb.timer/0.25))

	return OK
