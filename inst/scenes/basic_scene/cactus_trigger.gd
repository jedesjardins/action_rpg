extends Area2D

func _ready():
	var err = connect("body_entered", self, "on_body_entered")
	err = connect("body_exited", self, "on_body_exited")
	if err != OK:
		print("Problem")

func on_body_entered(body):
	if body != $"../StaticBody2D":
		var material = ShaderMaterial.new()
		var shader = load("res://resources/shaders/outline.shader")
		material.set_shader(shader)
		material.set_shader_param("outline_color", Color(1, 1, 1, 1))
		$"..".set_material(material)

func on_body_exited(body):
	if body != $"../StaticBody2D":
		$"..".set_material(null)
