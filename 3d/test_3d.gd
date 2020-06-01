extends Spatial

func _process(_delta):
	# swap active camera
	if Input.is_action_just_pressed("interact"):
		if $"Sprite3D/Camera".current:
			$"Sprite3D/Camera".current = false
			$"Camera".current = true
		elif $"Camera".current:
			$"Camera".current = false
			$"Sprite3D/Camera".current = true
