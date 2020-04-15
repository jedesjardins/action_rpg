extends Node2D

func _ready():
	var _err = $"CanvasLayer/CenterContainer/VBoxContainer/ResumeButton".connect("button_down", self, "resume")
	_err = $"CanvasLayer/CenterContainer/VBoxContainer/QuitButton".connect("button_down", self, "quit")

func resume():
	$"..".pop_scene()

func quit():
	var sm = $".."
	sm.pop_scene()
	sm.pop_scene()

	var main_menu_scene = load("res://inst/scenes/main_menu_scene/main_menu.tscn").instance()

	sm.push_scene(main_menu_scene)
