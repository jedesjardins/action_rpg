extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.has("item"))
	
	var animation_player = bb.entity.get_node("AnimationPlayer")
	var item_animation_player = bb.item.get_children()[0].get_node("AnimationPlayer")
	
#	if not bb.has("animation_chain"):
#		bb.entity_animation_chain = AnimationChain.new(animation_player)
#		bb.item_animation_chain = AnimationChain.new(item_animation_player)
	
	# start attack animation here
	var current_attack = bb.item.attacks["stab"]
	var current_animation_index = 0
	
	Helpers.play_animation_duration(
		animation_player,
		current_attack.entity_animations[current_animation_index] + "_down",
		current_attack.durations[current_animation_index])
	
	Helpers.play_animation_duration(
		item_animation_player,
		current_attack.item_animations[current_animation_index] + "_down",
		current_attack.durations[current_animation_index])
	
	bb.current_attack = current_attack
	bb.current_animation_index = current_animation_index
	
#	bb.entity_animation_chain.run(attack.entity_animations, attack.durations, "_down")
#	bb.item_animation_chain.run(attack.item_animations, attack.durations, "_down")
	
	return OK
