extends Node2D

var player: Entity

# Called when the node enters the scene tree for the first time.
func _ready():
	# add player to player group
	player = $"Knight"
	player.add_to_group("player", true)

	# set camera to follow the player
	var remote_transform = RemoteTransform2D.new()
	player.add_child(remote_transform)
	remote_transform.remote_path = Global.get_relative_path_from(remote_transform, $"Camera2D")

	# connect player damage to health bar
	var _err = player.get_node("Health").connect("damaged", $"HUD/StatusMarginContainer/ProgressBar", "change_health")

	# connect player damage to health bar
	if player.behavior:
		_err = player.behavior.connect("hold", $"HUD/ItemMarginContainer/PanelContainer/MarginContainer/CenterContainer/TextureRect", "hold")

	# ai should "target" the player
	$"base_human2".behavior.blackboard.target_entity = player

func _input(event):
	if(event is InputEventKey):
		if(event.is_pressed() and event.scancode == KEY_ESCAPE):
			var pause_scene = load("res://inst/scenes/pause_menu_scene/pause_menu.tscn").instance()
			$"..".push_scene(pause_scene, true)
