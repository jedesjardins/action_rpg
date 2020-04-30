tool
extends Node

onready var health = 100
var attached_hurtbox: Area2D

signal damaged

func attach_hurtbox(hurtbox: Area2D):
	# maybe add asserts to see if the hurtbox has the right layers set

	if attached_hurtbox:
		attached_hurtbox.disconnect("area_entered", self, "take_damage")

	attached_hurtbox = hurtbox

	if attached_hurtbox:
		var _err = attached_hurtbox.connect("area_entered", self, "take_damage")

func take_damage(area):
	if area is Hitbox and area.cached_damage_info != null:
		if area.get_logical_parent().ignored_node == $"..":
			return # hits the entity holding it

		health -= area.cached_damage_info.damage;
		print("Took damage, health is now: ", health)
		emit_signal("damaged", health)
	else:
		print("No DamageInfo to apply damage from")
