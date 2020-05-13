extends BTNode

func get_direction(bb):
	var mouse_position = Global.get_viewport_mouse_position(bb.entity.get_viewport())
	var angle_to_mouse = Global.get_angle_to_pos_from(mouse_position, bb.entity)
	var direction = int(floor(fmod((angle_to_mouse * 8 ) + .5, 8)))

	return direction

func tick(bb: Dictionary) -> int:
	if bb.current_attack.has("next_attack"):
		assert(not bb.current_attack.next_attack.empty())

		bb.next_attack = bb.current_attack.next_attack
		bb.next_direction = get_direction(bb)

	return OK
