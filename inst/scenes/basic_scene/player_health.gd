tool
extends Node

signal damaged

var attached_hurtbox: Area2D

onready var health = 100

func attach_hurtbox(hurtbox: Area2D):
	# maybe add asserts to see if the hurtbox has the right layers set

	if attached_hurtbox:
		attached_hurtbox.disconnect("area_entered", self, "on_Hurtbox_area_entered")

	attached_hurtbox = hurtbox

	if attached_hurtbox:
		var _err = attached_hurtbox.connect("area_entered", self, "on_Hurtbox_area_entered")

func on_Hurtbox_area_entered(area):
	if area is Hitbox and area.cached_damage_info != null:
		var logical_parent = area.get_logical_parent()

		if logical_parent is Weapon and logical_parent.ignored_node == $"..":
			return # hits the entity holding it

		health -= area.cached_damage_info.damage;
		print("Took damage, health is now: ", health)
		emit_signal("damaged", health)
	else:
		print("No DamageInfo to apply damage from")
