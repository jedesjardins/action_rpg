extends AnimationPlayer

func _ready():
	play("sparkling")

	var _err = get_parent().get_parent().connect("picked_up", self, "on_Weapon_picked_up")
	_err = get_parent().get_parent().connect("dropped", self, "on_Weapon_dropped")

func on_Weapon_picked_up():
	play("end_sparkling")

func _on_Weapon_dropped():
	play("start_sparkling")
	animation_set_next("start_sparkling", "sparkling")
