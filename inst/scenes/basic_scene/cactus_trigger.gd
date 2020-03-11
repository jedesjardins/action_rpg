extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var err = connect("body_entered", self, "highlight_parent")
	err = connect("body_exited", self, "unhighlight_parent")
	if err != OK:
		print("Problem")

func highlight_parent(body):
	if body != $"../StaticBody2D":
		var material = ShaderMaterial.new()
		var shader = load("res://resources/shaders/outline.shader")
		material.set_shader(shader)
		material.set_shader_param("outline_color", Color(1, 1, 1, 1))
		$"..".set_material(material)

func unhighlight_parent(body):
	if body != $"../StaticBody2D":
		$"..".set_material(null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
