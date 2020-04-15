extends Node2D

onready var focused = false

func _ready():
	var err = $"CanvasLayer/CenterContainer/VBoxContainer/ResumeButton".connect("button_down", self, "resume")
	print(err)
	err = $"CanvasLayer/CenterContainer/VBoxContainer/QuitButton".connect("button_down", self, "quit")

func resume():
	$"..".pop_scene()

func quit():
	var sm = $".."
	sm.pop_scene()
	sm.pop_scene()

	var main_menu_scene = load("res://inst/scenes/main_menu_scene/main_menu.tscn").instance()

	sm.push_scene(main_menu_scene)

func _unhandled_input(event):
	if (event is InputEventKey or event is InputEventAction) and not focused:
		$"CanvasLayer/CenterContainer/VBoxContainer/ResumeButton".grab_focus()
		focused = true

	if event is InputEventAction:
		print("Unhandled:", event.action)
