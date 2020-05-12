extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.entity.has_node("Health"))
	var health = bb.entity.get_node("Health")
	assert(health.damaged == true and not health.damaged_by == null)

	var attacking_entity = health.damaged_by
	var entity = bb.entity

	bb.knockback_velocity = (entity.global_position - attacking_entity.global_position).normalized() * bb.entity.configuration.walk_speed * 4

	return OK
