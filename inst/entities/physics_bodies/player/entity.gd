extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hitbox: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox = $"Hitbox"
	
#	hitbox.connect("area_entered", self, "on_hurtbox_entered")
#
## Called when the Hitbox enters an Area2D on the Hurtbox layer
#func on_hurtbox_entered(other_area_2d):
#	print("hurtbox hit entity")

func get_hitbox():
	return $"Hitbox"
