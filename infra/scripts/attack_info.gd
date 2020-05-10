extends Reference

class_name AttackInfo

var attacks: Dictionary
var first_attack_name = ""
var charge_attack_name = ""

func _init(info: Dictionary):
	assert(info.has("attacks"))
	attacks = info.attacks

	assert(info.has("first_attack"))
	first_attack_name = info.first_attack

	if info.has("charge_attack"):
		charge_attack_name = attacks[info.charge_attack]

func get_first_attack():
	if attacks.has(first_attack_name):
		return attacks[first_attack_name]

	return null

func get_charge_attack():
	if attacks.has(charge_attack_name):
		return attacks[charge_attack_name]

	return null

func get_attack(attack_name):
	if attacks.has(attack_name):
		return attacks[attack_name]

	return null
