extends Hitbox

func _ready():
	all_damage_infos = {
		"": {
			"damage": 5
		}
	}

	set_damage_info("")
