extends Node2D

onready var root = get_tree().get_root()
export(Vector2) var max_size

func _ready():
	
	root.connect("size_changed", self, "window_resize")
	window_resize()
	
func window_resize():
	var window_size = OS.get_window_size()
	root.set_size_override(true, window_size)
	
	var float_scale = window_size / max_size
	
	var rounded_scale = max(ceil(float_scale.x), ceil(float_scale.y))
	
	var rounded_scale_vec = Vector2(rounded_scale, rounded_scale)
	
	var sub_viewport_size = window_size / rounded_scale_vec
	
	$"Viewport".set_size_override(true, sub_viewport_size)
	$"ViewportSprite".scale = rounded_scale_vec

func _input(event):
	if(event is InputEventKey):
		if(event.is_pressed() and event.scancode == KEY_ESCAPE):
			get_tree().quit()
