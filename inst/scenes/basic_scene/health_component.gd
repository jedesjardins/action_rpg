tool
extends Node

signal damaged

export var health = 100

onready var damaged = false
onready var damaged_by = null

func _ready():
	var _err = get_parent().connect("ready", self, "on_Parent_ready")

func on_Parent_ready():
	var parent = get_parent()

	if parent.has_node("Hurtbox"):
		var _err = parent.get_node("Hurtbox").connect("area_entered", self, "on_Hurtbox_area_entered")

func on_Hurtbox_area_entered(area):
	if area is Hitbox and area.cached_damage_info != null:
		var area_parent = area.get_parent()
		var self_parent = get_parent()

		# This entities own Hitbox is hitting its Hurtbox
		if area_parent == self_parent:
			return # hits the entity holding it

		# The item this entity is holding is hitting it's Hurtbox
		if self_parent.has_node("Hand") and self_parent.get_node("Hand").item == area_parent:
			return

		health -= area.cached_damage_info.damage;
		damaged = true
		damaged_by = area_parent
		print("Took damage, health is now: ", health)
		emit_signal("damaged", health)
	else:
		print("No DamageInfo to apply damage from")
