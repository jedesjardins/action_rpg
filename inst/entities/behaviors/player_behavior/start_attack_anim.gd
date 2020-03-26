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
	var attack = bb.item.attack_animations["stab"]
	var entity_animation_list = [
		attack.warmup_animation.entity_animation + "_down",
		attack.main_animation.entity_animation + "_down",
		attack.cooldown_animation.entity_animation + "_down"
	]
	var item_animation_list = [
		attack.warmup_animation.item_animation + "_down",
		attack.main_animation.item_animation + "_down",
		attack.cooldown_animation.item_animation + "_down"
	]
	var duration = [
		attack.warmup_animation.duration,
		attack.main_animation.duration,
		attack.cooldown_animation.duration
	]
	
	bb.entity_animation_chain.run(entity_animation_list, duration)
	bb.item_animation_chain.run(item_animation_list, duration)
	
	return OK
