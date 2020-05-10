extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.has("damaged"))
	assert(bb.has("damaged_by"))

	var attacking_entity = bb.damaged_by
	var entity = bb.entity

	bb.knockback_velocity = (entity.global_position - attacking_entity.global_position).normalized() * bb.entity.walk_speed * 4

	return OK
