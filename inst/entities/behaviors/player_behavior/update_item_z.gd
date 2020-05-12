extends BTNode

# always returns OK since it's passive
func tick(bb: Dictionary) -> int:
	assert(bb.has("entity"))
	assert(bb.entity.has_node("Hand"))
	var hand = bb.entity.get_node("Hand")

	if bb.item:
		var z = bb.entity.get_global_transform_with_canvas().get_origin().y
		
		bb.item.sprite.z_index = z + hand.z_modifier

	return OK
