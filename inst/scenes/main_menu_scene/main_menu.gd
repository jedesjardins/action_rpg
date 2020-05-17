extends Node2D

onready var focused = false

func _ready():
	var _err = $"CanvasLayer/CenterContainer/VBoxContainer/VBoxContainer/NewGameButton".connect("button_down", self, "on_NewGame_button_down")
	_err = $"CanvasLayer/CenterContainer/VBoxContainer/VBoxContainer/QuitGameButton".connect("button_down", self, "on_QuitGame_button_down")

func _unhandled_input(event):
	if (event is InputEventKey or event is InputEventAction) and not focused:
		$"CanvasLayer/CenterContainer/VBoxContainer/VBoxContainer/NewGameButton".grab_focus()
		focused = true

func on_NewGame_button_down():
#	var game_scene = load("res://inst/scenes/basic_scene/basic_scene.tscn").instance()
	var game_scene = load("res://inst/scenes/game_scene/game.tscn").instance()
	$"..".swap_scene(game_scene)

func on_QuitGame_button_down():
	get_tree().quit()
