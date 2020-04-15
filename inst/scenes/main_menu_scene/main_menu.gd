extends Node2D

func _ready():
	var _err = $"CanvasLayer/CenterContainer/VBoxContainer/NewGameButton".connect("button_down", self, "new_game")
	_err = $"CanvasLayer/CenterContainer/VBoxContainer/QuitGameButton".connect("button_down", self, "quit_game")


func new_game():
	var game_scene = load("res://inst/scenes/basic_scene/basic_scene.tscn").instance()
	$"..".swap_scene(game_scene)

func quit_game():
	print("Quit...")
	get_tree().quit()
