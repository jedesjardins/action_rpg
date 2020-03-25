extends Node2D

var player: Entity

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"base_human"
	player.add_to_group("player", true)
		
	var remote_transform = RemoteTransform2D.new()
	player.add_child(remote_transform)
	remote_transform.remote_path = Helpers.get_relative_path_from(remote_transform, $"Camera2D")
	
	var err = player.hurtbox.connect("area_entered", self, "player_entered_hitbox_area")
	if err != OK:
		print("Problem")
	err = player.hurtbox.connect("body_entered", self, "player_entered_hitbox_body")
	if err != OK:
		print("Problem")
	
#	player.behavior.hold_item($"Sprite")
	$"base_human2".behavior.blackboard.target_entity = player

func player_entered_hitbox_area(area):
	print("player_entered_hitbox_area ", area.get_path())
	
func player_entered_hitbox_body(body):
	print("player_entered_hitbox_body ", body.get_path())
