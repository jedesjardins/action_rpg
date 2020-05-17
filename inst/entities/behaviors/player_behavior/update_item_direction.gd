extends BTNode

# always returns OK since it's passive
func tick(bb: Dictionary) -> int:
	assert(bb.has("direction"))
	assert(bb.has("direction_string"))

	if bb.item:
		var ap = bb.item.get_node("AnimationPlayer")
		ap.play("held_" + bb.direction_string[bb.direction])

	return OK
