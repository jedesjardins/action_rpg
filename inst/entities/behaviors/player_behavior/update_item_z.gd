extends BTNode

# always returns OK since it's passive
func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.entity.has_node("Hand"))
	var hand = bb.entity.get_node("Hand")

	if bb.item and bb.item.has_node("Sprite"):
		var z = bb.entity.get_node("Sprite").z_index

		bb.item.get_node("Sprite").z_index = z + hand.z_modifier

	return OK
