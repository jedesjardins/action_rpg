extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("physics_body"))
	
	var animation_player = bb.physics_body.get_node("AnimationPlayer")
	
	if not bb.has("animation_chain"):
		bb.animation_chain = AnimationChain.new(animation_player)
	
	# start attack animation here
	# TODO: this will look up the current attack animation and durations
	bb.animation_chain.run(["idle_down", "idle_down_right", "idle_down_left"], [1, 1, 1])
	
	return OK
