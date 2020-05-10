extends ColorRect

func _ready():
	var _err = $"Area2D".connect("area_entered", self, "on_Area2D_area_entered")

func on_Area2D_area_entered(_area):
	print(_area)
