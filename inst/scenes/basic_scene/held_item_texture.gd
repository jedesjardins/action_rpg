extends TextureRect

func hold(item):
	if item != null:
		assert(item is Weapon)
		texture = load(item.icon)
	else:
		texture = null
