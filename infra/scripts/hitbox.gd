extends ChildArea

class_name Hitbox

var modifier: Dictionary setget set_modifier, get_modifier
var cached_damage_info: Dictionary setget set_cached_damage_info, get_damage_info
onready var current_info_key = ""
var all_damage_infos: Dictionary

func set_modifier(m: Dictionary):
	# TODO: Recalculate cached_damage_info
	modifier = m
	
	recalculate_damage_info()

func get_modifier():
	return modifier

func set_cached_damage_info(_di: Dictionary):
	# TODO: Recalculate cached_damage_info
	assert(false)

func set_damage_info(key: String):
	current_info_key = key
	
	recalculate_damage_info()

func get_damage_info():
	return cached_damage_info

# Helper function
func recalculate_damage_info():
	assert(all_damage_infos.has(current_info_key))
	
	cached_damage_info = all_damage_infos[current_info_key]
