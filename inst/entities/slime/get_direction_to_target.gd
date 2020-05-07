extends BTNode

func tick(bb:Dictionary) -> int:
	assert(bb.has("target"))

	var angle_to_mouse = Helpers.get_angle_to_pos_from(bb.target.global_position, bb.entity)
	bb.direction = int(floor(fmod((angle_to_mouse * 8 ) + .5, 8)))

	return OK
