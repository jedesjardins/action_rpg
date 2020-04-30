extends ColorRect

func _ready():
	print("ayo")
	var _err = $"Area2D".connect("area_entered", self, "hitbox_entered")

func hitbox_entered(_area):
	print(_area)
