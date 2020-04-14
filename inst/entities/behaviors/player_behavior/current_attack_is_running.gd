extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.has("item"))
	assert(bb.has("current_attack"))
	assert(bb.has("current_animation_index"))

	var animation_player = bb.entity.get_node("AnimationPlayer")
	var item_animation_player = bb.item.get_children()[0].get_node("AnimationPlayer")

	var direction_string = "_" + bb.direction_string[bb.direction]
	var current_entity_animation = bb.current_attack.entity_animations[bb.current_animation_index] + direction_string
	var current_item_animation = bb.current_attack.item_animations[bb.current_animation_index] + direction_string

	
	if animation_player.current_animation == current_entity_animation and item_animation_player.current_animation == current_item_animation:
		return OK

	return FAILED
