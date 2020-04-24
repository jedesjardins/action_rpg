extends Node2D

class_name GameState

var current_zone: Node # Zone
var player: Entity

func _ready():
	# add player to player group
	player = $"Entities/Knight"
	player.add_to_group("player", true)

	# set camera to follow the player
	var remote_transform = RemoteTransform2D.new()
	player.add_child(remote_transform)
	remote_transform.remote_path = Helpers.get_relative_path_from(remote_transform, $"Camera2D")

	# connect player damage to health bar
	var _err = player.get_node("Health").connect("damaged", $"HUD/StatusMarginContainer/ProgressBar", "change_health")

	# connect player damage to health bar
	if player.behavior:
		_err = player.behavior.connect("hold", $"HUD/ItemMarginContainer/PanelContainer/MarginContainer/CenterContainer/TextureRect", "hold")

func _input(event):
	if(event is InputEventKey):
		if(event.is_pressed() and event.scancode == KEY_ESCAPE):
			var pause_scene = load("res://inst/scenes/pause_menu_scene/pause_menu.tscn").instance()
			$"..".push_scene(pause_scene, true)

#func set_current_area(zone):
##	assert(zone is Zone)
#	# get_required_zones() returns the json configuration of the zone?
#	var required_zones = zone.get_required_zones()
#	var _loaded_required_zones = {}
#	for child_zone in $"Zones".get_children():
##		assert(child_zone is Zone)
#		if not child_zone in required_zones:
#			child_zone.exit()
#			child_zone.queue_free()
#		else:
#			pass
#
#	# should the next zones loading get queued
#
#func add_node_to_state(_node):
#	pass
