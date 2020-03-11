extends Node2D

var Player: BaseEntity

# Called when the node enters the scene tree for the first time.
func _ready():
	Player = $"BaseEntity"
		
	var remote_transform = RemoteTransform2D.new()
	Player.physics_body.add_child(remote_transform)
	remote_transform.remote_path = Helpers.get_relative_path_from(remote_transform, $"Camera2D")
	
	var err = Player.physics_body.hitbox.connect("area_entered", self, "player_entered_hurtbox_area")
	if err != OK:
		print("Problem")
	err = Player.physics_body.hitbox.connect("body_entered", self, "player_entered_hurtbox_body")
	if err != OK:
		print("Problem")

func player_entered_hurtbox_area(area):
	print("player_entered_hurtbox_area ", area.get_path())
	
func player_entered_hurtbox_body(body):
	print("player_entered_hurtbox_body ", body.get_path())
