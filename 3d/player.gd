extends Sprite3D

const move_speed = 48

func _process(delta):

	var move_distance = .01 * move_speed * delta

	if Input.is_action_pressed("right"):
		var translation = get_translation()
		set_translation(translation + Vector3(move_distance, 0, 0))
	elif Input.is_action_pressed("left"):
		var translation = get_translation()
		set_translation(translation + Vector3(-1 * move_distance, 0, 0))
	elif Input.is_action_pressed("down"):
		var translation = get_translation()
		set_translation(translation + Vector3(0, -1 * move_distance, move_distance))
	elif Input.is_action_pressed("up"):
		var translation = get_translation()
		set_translation(translation + Vector3(0, move_distance, -1 * move_distance))
