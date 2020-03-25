extends Area2D

func _ready():
	var err = connect("body_entered", self, "hit")
	if err != OK:
		print("Error initializing Sword")
	
	err = connect("area_entered", self, "clash")
	if err != OK:
		print("Error initializing Sword")

func hit(_body):
	print("hit")

func clash(area):
	var hurtbox_bit = 2
	var hitbox_bit = 1
	
	if area.get_collision_layer_bit(hurtbox_bit):
		print("Dealt damage to Hurtbox ", area.get_path())
	
	if area.get_collision_layer_bit(hitbox_bit):
		print("Clashed with Hurtbox ", area.get_path())
