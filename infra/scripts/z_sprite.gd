extends Sprite

class_name ZSprite

func highlight():
	var current_material = ShaderMaterial.new()
	var shader = load("res://resources/shaders/outline.shader")
	current_material.set_shader(shader)
	current_material.set_shader_param("outline_color", Color(1, 1, 1, 1))
	set_material(current_material)

func unhighlight():
	set_material(null)
	set_process(false)

func _process(_delta):
	# TODO: This may get buggy as things get closer to the top edge of the screen
	#       could fix with a negative offset to continue to order things "above" the screen
	z_index = int(max(0, int(get_global_transform_with_canvas().get_origin().y)))

