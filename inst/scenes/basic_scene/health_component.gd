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

#func attach_hurtbox(hurtbox: Area2D):
#	# maybe add asserts to see if the hurtbox has the right layers set
#
#	if attached_hurtbox:
#		attached_hurtbox.disconnect("area_entered", self, "on_Hurtbox_area_entered")
#
#	attached_hurtbox = hurtbox
#
#	if attached_hurtbox:
#		var _err = attached_hurtbox.connect("area_entered", self, "on_Hurtbox_area_entered")

func on_Hurtbox_area_entered(area):
	if area is Hitbox and area.cached_damage_info != null:
		var parent = area.get_parent()

		# TODO: Hacky fix, since Hitboxes are children of Entities, but grandchildren of Weapons.
		#       Fix by remaking Weapons like Entities, or can weapons BE entities?
		if not parent is Entity:
			parent = parent.get_parent()

		if parent == get_parent() or (parent is Weapon and parent.ignored_node == $".."):
			return # hits the entity holding it

		health -= area.cached_damage_info.damage;
		damaged = true
		damaged_by = parent
		print("Took damage, health is now: ", health)
		emit_signal("damaged", health)
	else:
		print("No DamageInfo to apply damage from")
