extends BTNode

func start_next_attack(bb: Dictionary):
	assert(bb.has("entity"))
	assert(bb.has("item"))
	
	bb.current_attack = bb.item.attacks[bb.next_attack]
	bb.current_animation_index = 0
	var _ret = bb.erase("next_attack")
	
	var animation_player = bb.entity.get_node("AnimationPlayer")
	var item_animation_player = bb.item.get_children()[0].get_node("AnimationPlayer")
	
	var direction_string = "_" + bb.direction_string[bb.direction]
	
	Helpers.play_animation_duration(
		animation_player,
		bb.current_attack.entity_animations[bb.current_animation_index] + direction_string,
		bb.current_attack.durations[bb.current_animation_index])
	
	Helpers.play_animation_duration(
		item_animation_player,
		bb.current_attack.item_animations[bb.current_animation_index] + direction_string,
		bb.current_attack.durations[bb.current_animation_index])

func start_next_anim(bb: Dictionary):
	assert(bb.has("entity"))
	assert(bb.has("item"))
	
	bb.current_animation_index += 1

	var animation_player = bb.entity.get_node("AnimationPlayer")
	var item_animation_player = bb.item.get_children()[0].get_node("AnimationPlayer")
	
	var direction_string = "_" + bb.direction_string[bb.direction]
	
	Helpers.play_animation_duration(
		animation_player,
		bb.current_attack.entity_animations[bb.current_animation_index] + direction_string,
		bb.current_attack.durations[bb.current_animation_index])

	Helpers.play_animation_duration(
		item_animation_player,
		bb.current_attack.item_animations[bb.current_animation_index] + direction_string,
		bb.current_attack.durations[bb.current_animation_index])

func end_attack(bb: Dictionary):
	var _ret
	_ret = bb.erase("current_attack")
	_ret = bb.erase("current_animation_index")
	_ret = bb.erase("next_attack")

func tick(bb: Dictionary) -> int:
	assert(bb.has("current_attack"))
	assert(bb.has("current_animation_index"))
	
	var current_attack = bb.current_attack
	var current_animation_index = bb.current_animation_index
	
	var animation_count = current_attack.entity_animations.size()
	
	if current_animation_index == animation_count - 1: # last animation
		if bb.has("next_attack"):
			start_next_attack(bb)
			return OK
		else:
			end_attack(bb)
			return FAILED
	else:
		if current_animation_index == animation_count - 2 and bb.has("next_attack") and current_attack.type == "combo": # second to last animation
			start_next_attack(bb)
			return OK
		else:
			start_next_anim(bb)
			return OK
