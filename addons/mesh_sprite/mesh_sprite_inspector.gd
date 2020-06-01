tool
extends EditorInspectorPlugin

var button = null

func _init(bottom_panel_button):
	button = bottom_panel_button

func can_handle(object):
	if object is MeshSprite:
		print("Is Mesh Sprite")
		if button:
			print("Has button")
			button.show()
	else:
		print("Is not Mesh Sprite")
		if button:
			print("Has button")
			button.hide()

	return false
