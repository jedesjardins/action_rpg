extends Camera

export var speed = 5
export var max_speed = 20
export var wheel_speed = 5
export var fov_speed = 20
export var size_factor = 0.1
export var rotate_speed_x = 0.005
export var rotate_speed_y = 0.005

func _unhandled_input(event):
	var mbutton := event as InputEventMouseButton
	var mmotion :InputEventMouseMotion = event as InputEventMouseMotion
	
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		if mmotion:
			var x = mmotion.relative.x
			var y = mmotion.relative.y
			rotation.x = clamp(rotation.x - y * rotate_speed_y, -PI/2 + 0.001, PI/2)
			rotation.y = rotation.y - x * rotate_speed_x
	if mbutton:
		var dir = 0
		if Input.is_mouse_button_pressed(BUTTON_WHEEL_UP):
			dir += 1
		if Input.is_mouse_button_pressed(BUTTON_WHEEL_DOWN):
			dir -= 1
		if Input.is_key_pressed(KEY_CONTROL):
			speed = clamp(speed + dir, 1, max_speed)
		else:
			translate(Vector3.FORWARD * dir * wheel_speed)

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):			
		var vec = Vector3.ZERO
		if Input.is_key_pressed(KEY_W): vec += Vector3.FORWARD
		if Input.is_key_pressed(KEY_A): vec += Vector3.LEFT
		if Input.is_key_pressed(KEY_S): vec += Vector3.BACK
		if Input.is_key_pressed(KEY_D): vec += Vector3.RIGHT
		if Input.is_key_pressed(KEY_CONTROL):
			fov = clamp(fov + vec.z * fov_speed * delta, 1, 179)
			size = clamp(size * (1 + (vec.x * size_factor * delta)), 0.001, INF)
		else:
			translate(vec * speed * delta)