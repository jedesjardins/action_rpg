extends Node2D

onready var focused = false

func _ready():
	var _err = $"CanvasLayer/CenterContainer/VBoxContainer/ResumeButton".connect("button_down", self, "on_ResumeButton_button_down")
	_err = $"CanvasLayer/CenterContainer/VBoxContainer/QuitButton".connect("button_down", self, "on_QuitButton_button_down")

func _unhandled_input(event):
	if (event is InputEventKey or event is InputEventAction) and not focused:
		$"CanvasLayer/CenterContainer/VBoxContainer/ResumeButton".grab_focus()
		focused = true

	if event is InputEventAction:
		print("Unhandled:", event.action)

func on_ResumeButton_button_down():
	$"..".pop_scene()

func on_QuitButton_button_down():
	var sm = $".."
	sm.pop_scene()
	sm.pop_scene()

	var main_menu_scene = load("res://inst/scenes/main_menu_scene/main_menu.tscn").instance()

	sm.push_scene(main_menu_scene)


