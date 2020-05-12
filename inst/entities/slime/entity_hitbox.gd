
extends Hitbox

var attack_info: AttackInfo

func _ready():
	var _err = get_parent().connect("ready", self, "on_Parent_ready")

func on_Parent_ready():
	var parent = get_parent()

	print("on_Parent_ready: ", parent.get_path())

	assert(parent.configuration.has("damage_infos"))
	all_damage_infos = parent.configuration.damage_infos

	attack_info = AttackInfo.new(parent.configuration)
