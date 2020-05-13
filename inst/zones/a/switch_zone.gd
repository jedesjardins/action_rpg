extends Area2D

var Log = Logger.get_logger("switch_zone.gd")

func _ready():
	var _err = connect("body_entered", self, "switch_to_b")

func switch_to_b(body):
	if not body.is_in_group("player"):
		return

	Log.info("Switch to Zone B Triggered", "switch_to_b(_body)")

	var game_state = get_node(Global.get_root_path_of(self))
	var current_zone = game_state.get_node("Zones/ZoneA")

	yield(get_tree(), "idle_frame")

	game_state.get_node("Zones").remove_child(current_zone)
	current_zone.remove_child(game_state.player)

	var next_zone_scene = load("res://inst/zones/b/zone_b.tscn")
	var next_zone = next_zone_scene.instance()
	game_state.get_node("Zones").add_child(next_zone)
	next_zone.add_child(game_state.player)
	game_state.player.global_position = Vector2(50, 200)

	current_zone.queue_free()
