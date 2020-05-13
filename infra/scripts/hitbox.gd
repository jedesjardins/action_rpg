
class_name Hitbox
extends Area2D

var modifier: Dictionary setget set_modifier, get_modifier
var cached_damage_info: Dictionary setget set_cached_damage_info, get_damage_info
var all_damage_infos: Dictionary
var attack_info: AttackInfo

onready var current_info_key = ""

func _ready():
	var _err = get_parent().connect("ready", self, "on_Parent_ready")

func on_Parent_ready():
	var parent = get_parent()

	assert(parent.configuration.has("damage_infos"))
	all_damage_infos = parent.configuration.damage_infos

	attack_info = AttackInfo.new(parent.configuration)

func set_modifier(m: Dictionary):
	modifier = m

	recalculate_damage_info()

func get_modifier():
	return modifier

func set_cached_damage_info(_di: Dictionary):
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
