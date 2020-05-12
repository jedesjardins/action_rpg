extends BTNode

func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.entity.has_node("Hand"))
	var hand = bb.entity.get_node("Hand")

	if hand.item:
		bb.item = hand.item
		return OK

	return FAILED
