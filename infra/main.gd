extends Node2D

onready var root = get_tree().get_root()
export(Vector2) var max_size
onready var current_scale = 1.0

func _ready():
	root.connect("size_changed", self, "window_resize")
	window_resize()

func window_resize():
	var window_size = OS.get_window_size()
	root.set_size_override(true, window_size)

	var float_scale = window_size / max_size

	current_scale = max(ceil(float_scale.x), ceil(float_scale.y))

	var rounded_scale_vec = Vector2(current_scale, current_scale)

	var sub_viewport_size = window_size / rounded_scale_vec

	$"Viewport".set_size_override(true, sub_viewport_size)
	$"ViewportSprite".scale = rounded_scale_vec

func _input(event):
	# TODO: events related to screen space must be translated to the sub viewport

	if event is InputEventMouse:
		event.global_position /= current_scale
		event.position /= current_scale

	if event is InputEventMouseMotion:
		event.relative /= current_scale
		event.speed /= current_scale

	$"Viewport".input(event)

func _unhandled_input(event):
	if(event is InputEventKey):
		if(event.is_pressed() and event.scancode == KEY_ESCAPE):
			get_tree().quit()
