extends Area2D

func _ready():
	var _err = connect("body_entered", self, "switch_to_b")

func switch_to_b(body):
	print(body.get_path())

	var root_state = get_node(Helpers.get_root_path_of(self))
	var current_zone = root_state.get_node("Zones/ZoneA")
	current_zone.queue_free()

	var next_zone = load("res://inst/zones/b/zone_b.tscn")

	# switch_to_b is called on an alternate thread (reacting to physics), where
	# adding a child is unsafe
	root_state.get_node("Zones").call_deferred("add_child", next_zone.instance())

	var player = root_state.player
	player.position = Vector2(50, 50)
	print(player.position)
	
