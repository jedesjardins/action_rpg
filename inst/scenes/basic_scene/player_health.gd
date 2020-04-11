tool
extends Node

onready var health = 100
var attached_hurtbox: Area2D

func attach_hurtbox(hurtbox: Area2D):
	# maybe add asserts to see if the hurtbox has the right layers set
	
	if attached_hurtbox:
		attached_hurtbox.disconnect("area_entered", self, "take_damage")
	
	attached_hurtbox = hurtbox
	
	if attached_hurtbox:
		var _err = attached_hurtbox.connect("area_entered", self, "take_damage")

func take_damage(_area):
	health -= 1;
	print("Took damage, health is now: ", health)
