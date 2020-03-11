extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func get_last_child() -> Node:
	var child_count = get_child_count()
	
	if get_child_count() == 0:
		return null
	
	return get_children()[child_count-1]

func push_scene(scene):
	var current_scene = get_last_child()
	
	if current_scene:
		current_scene.pause()
		current_scene.hide()
	
	add_child(scene)

func pop_scene():
	var current_scene = get_last_child()
	
	if current_scene:
		current_scene.free()
	
	var last_scene = get_last_child()
	
	if not last_scene:
		get_tree().quit()
	
	last_scene.unpause()
	last_scene.show()

func swap_scene(next_scene):
	var current_scene = get_last_child()
	
	if current_scene:
		current_scene.free()
	
	add_child(next_scene)
