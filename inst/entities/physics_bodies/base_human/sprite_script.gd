extends Sprite

func highlight():
	var material = ShaderMaterial.new()
	var shader = load("res://resources/shaders/outline.shader")
	material.set_shader(shader)
	material.set_shader_param("outline_color", Color(1, 1, 1, 1))
	set_material(material)

func unhighlight():
	set_material(null)
