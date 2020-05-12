extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))

	var has_item = bb.has("item")

	var animation_player = bb.entity.get_node("AnimationPlayer")

	# start attack animation here

	var attack_info = null
	if has_item:
		attack_info = bb.item.get_node("Hitbox").attack_info
	else:
		attack_info = bb.entity.get_node("Hitbox").attack_info

	var current_attack = attack_info.get_first_attack()
	var current_animation_index = 0
	var direction_string = "_" + bb.direction_string[bb.direction]

	Helpers.play_animation_duration(
		animation_player,
		current_attack.entity_animations[current_animation_index] + direction_string,
		current_attack.durations[current_animation_index])

	if has_item:
		var item_animation_player = bb.item.get_node("AnimationPlayer")

		Helpers.play_animation_duration(
			item_animation_player,
			current_attack.item_animations[current_animation_index] + direction_string,
			current_attack.durations[current_animation_index])

		if bb.item.has_node("Hitbox"):
			bb.item.get_node("Hitbox").modifier = {}

	bb.current_attack = current_attack
	bb.current_animation_index = current_animation_index

	return OK
