extends Node2D

onready var focused = false

func _ready():
	var _err = $"CanvasLayer/CenterContainer/VBoxContainer/VBoxContainer/NewGameButton".connect("button_down", self, "new_game")
	_err = $"CanvasLayer/CenterContainer/VBoxContainer/VBoxContainer/QuitGameButton".connect("button_down", self, "quit_game")

func new_game():
	var game_scene = load("res://inst/scenes/basic_scene/basic_scene.tscn").instance()
	$"..".swap_scene(game_scene)

func quit_game():
	get_tree().quit()

func _unhandled_input(event):
	if (event is InputEventKey or event is InputEventAction) and not focused:
		$"CanvasLayer/CenterContainer/VBoxContainer/VBoxContainer/NewGameButton".grab_focus()
		focused = true
