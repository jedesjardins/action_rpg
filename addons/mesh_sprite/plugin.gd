tool
extends EditorPlugin

var editor_button = null
var editor = null
var inspector = null

func _enter_tree():
	# add MeshInstance type
	add_custom_type("MeshSprite", "MeshInstance", preload("mesh_sprite.gd"), null)
	
	# load editor and get it's button
	editor = preload("mesh_sprite_editor.tscn").instance()
	
	var editor_button = add_control_to_bottom_panel(editor, "Mesh Sprite Editor")
	editor_button.connect("button_up", self, "on_EditorButton_button_up")
	editor_button.hide()
	
	# load the inspector and get it's button
	inspector = preload("./mesh_sprite_inspector.gd").new(editor_button)
	add_inspector_plugin(inspector)
	
	

func on_EditorButton_button_up():
	pass

func _exit_tree():
	remove_control_from_bottom_panel(editor)
	if editor != null:
		editor.queue_free()
