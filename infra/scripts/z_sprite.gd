
class_name ZSprite
extends Sprite

func highlight():
	var current_material = ShaderMaterial.new()
	var shader = load("res://resources/shaders/outline.shader")
	current_material.set_shader(shader)
	current_material.set_shader_param("outline_color", Color(1, 1, 1, 1))
	set_material(current_material)

func unhighlight():
	set_material(null)
	set_process(false)

func _ready():
	z_index = int(max(0, int(get_global_transform_with_canvas().get_origin().y)))

	if get_parent() is Weapon:
		var _err = get_parent().connect("dropped", self, "on_Parent_dropped")

func _on_Parent_dropped():
	z_index = int(max(0, int(get_global_transform_with_canvas().get_origin().y)))
