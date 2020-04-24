extends Hitbox

# Called when the node enters the scene tree for the first time.
func _ready():
	var _res1 = connect("area_entered", self, "on_hurtbox_area_entered")
	var _res2 = connect("body_entered", self, "on_hurtbox_body_entered")

	all_damage_infos = {
		"default": {
			"damage": 10
		}
	}

	set_damage_info("default")

func on_hurtbox_area_entered(_hitbox):
	print("An Area2D entered the Cactus")

func on_hurtbox_body_entered(_hitbox):
	print("An Body entered the Cactus")

