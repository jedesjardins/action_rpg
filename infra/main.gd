extends Node2D


export(Vector2) var min_size

var viewport_transform: Transform2D
var size_cap: float

onready var root = get_tree().get_root()

func _ready():
	assert($"Viewport".size.x == $"Viewport".size.y)
	assert(min_size.x == min_size.y)

	size_cap = $"Viewport".size.x

	root.connect("size_changed", self, "on_Root_size_changed")
	on_Root_size_changed()

func _input(event):
	if event is InputEventMouse:
		var affine_inverse = viewport_transform.affine_inverse()
		event.global_position = affine_inverse.xform(event.global_position)
		event.position = affine_inverse.xform(event.position)

		if event is InputEventMouseMotion:
			event.relative = affine_inverse.xform(event.relative)
			event.speed = affine_inverse.xform(event.speed)

	$"Viewport".input(event)

func _unhandled_input(event):
	if event is InputEventMouse:
		var affine_inverse = viewport_transform.affine_inverse()
		event.global_position = affine_inverse.xform(event.global_position)
		event.position = affine_inverse.xform(event.position)

		if event is InputEventMouseMotion:
			event.relative = affine_inverse.xform(event.relative)
			event.speed = affine_inverse.xform(event.speed)

	$"Viewport".unhandled_input(event)

func on_Root_size_changed():
	var window_size = OS.get_window_size()
	root.set_size_override(true, window_size)

	var fscale = window_size / min_size
	var current_scale = min(floor(fscale.x), floor(fscale.y))

	var viewport_size = window_size / current_scale
	viewport_size.x = ceil(viewport_size.x)
	viewport_size.y = ceil(viewport_size.y)

	var current_position = Vector2(0, 0)

	if viewport_size.x > size_cap:
		current_position.x = floor((viewport_size.x - size_cap) * current_scale / 2)
		viewport_size.x = size_cap

	if viewport_size.y > size_cap:
		current_position.y = floor((viewport_size.y - size_cap) * current_scale / 2)
		viewport_size.y = size_cap

	$"Viewport".set_size_override(true, viewport_size)

	viewport_transform = Transform2D.IDENTITY.scaled(Vector2(current_scale, current_scale)).translated(current_position/current_scale)
	$"ViewportSprite".transform = viewport_transform

func transform_position(pos: Vector2):
	# return viewport_transform.affine_inverse().xform(pos)
	return viewport_transform.affine_inverse().xform(pos)
