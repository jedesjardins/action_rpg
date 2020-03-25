extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("physics_body"))
	
	var animation_player = bb.physics_body.get_node("AnimationPlayer")
	var item_animation_player = bb.item.get_children()[0].get_node("AnimationPlayer")
	
	if not bb.has("animation_chain"):
		bb.entity_animation_chain = AnimationChain.new(animation_player)
		bb.item_animation_chain = AnimationChain.new(item_animation_player)
	
	# start attack animation here
	# TODO: this will look up the current attack animation and durations
	bb.entity_animation_chain.run(["attack_warm_up", "attack", "idle_down"], [1, 1, 1])
	bb.item_animation_chain.run(["stab_disabled_down", "stab_enabled_down", "stab_disabled_down"], [1, 1, 1])
	
	return OK
