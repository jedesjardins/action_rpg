extends Node2D

var player: Entity

# Called when the node enters the scene tree for the first time.
func _ready():
	# add player to player group
	player = $"base_human"
	player.add_to_group("player", true)
	
	# set camera to follow the player
	var remote_transform = RemoteTransform2D.new()
	player.add_child(remote_transform)
	remote_transform.remote_path = Helpers.get_relative_path_from(remote_transform, $"Camera2D")
	
	# ai should "target" the player
	$"base_human2".behavior.blackboard.target_entity = player
