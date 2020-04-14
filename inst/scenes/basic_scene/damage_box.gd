extends Hitbox

func _ready():
	all_damage_infos = {
		"block": {
			"damage": 10
		}
	}
	
	set_damage_info("block")
