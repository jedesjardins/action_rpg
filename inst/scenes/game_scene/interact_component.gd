

extends Node2D

var interact_map: Dictionary
var next_interact_script: Node
var Log = Logger.SubLogger.new(Logger.Level.TRACE, "interact_component.gd")

onready var can_interact = true

func add_interact_script(script):
	if not next_interact_script:
		Log.debug("playing reveal", "add_interact_script(script)")
		$"AnimationPlayer".play("reveal")
		$"AnimationPlayer".advance(0)

	interact_map[script] = true
	next_interact_script = script

func remove_interact_script(script):
	var _script_existed = interact_map.erase(script)

	if next_interact_script == script:
		if interact_map.keys().size() > 0:
			Log.info("There are more interacting scripts, playing reveal", "remove_interact_script(script)")
			$"AnimationPlayer".play("reveal")
			next_interact_script = interact_map.keys()[0]
		else:
			Log.info("No more interacting scripts, playing hide", "remove_interact_script(script)")
			$"AnimationPlayer".play("hide")
			next_interact_script = null

func interact():
	if not can_interact or next_interact_script == null:
		return

	can_interact = false
	var result = next_interact_script.interact_with(get_parent())
	if result is GDScriptFunctionState:
		yield(result, "completed")
	can_interact = true
