extends Sprite

var time = 0
var current_material

func _ready():
	set_process(false)

func _process(delta):
	time += delta
	current_material.set_shader_param("elapsed_time", time)

	if time > 1:
		current_material = null
		set_material(null)
		set_process(false)

func highlight():
	current_material = ShaderMaterial.new()
	var shader = load("res://resources/shaders/outline.shader")
	current_material.set_shader(shader)
	current_material.set_shader_param("outline_color", Color(1, 1, 1, 1))
	set_material(current_material)

func unhighlight():	
	current_material = null
	set_material(null)
	set_process(false)

func flash():
	set_process(true)
	time = 0
	current_material = ShaderMaterial.new()
	var shader = load("res://resources/shaders/flash.shader")
	current_material.set_shader(shader)
	current_material.set_shader_param("fill_color", Color(1, 1, 1, 1))
	current_material.set_shader_param("flash_per_s", 5)
	current_material.set_shader_param("elapsed_time", time)
	set_material(current_material)



