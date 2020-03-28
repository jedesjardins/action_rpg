extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.has("item"))
	
	var animation_player = bb.entity.get_node("AnimationPlayer")
	var item_animation_player = bb.item.get_children()[0].get_node("AnimationPlayer")
	
	if not bb.has("animation_chain"):
		bb.entity_animation_chain = AnimationChain.new(animation_player)
		bb.item_animation_chain = AnimationChain.new(item_animation_player)
	
	# start attack animation here
	var attack = bb.item.attacks["stab"]
	
	bb.entity_animation_chain.run(attack.entity_animations, attack.durations, "_down")
	bb.item_animation_chain.run(attack.item_animations, attack.durations, "_down")
	
	return OK
