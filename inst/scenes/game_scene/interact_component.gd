
extends Node

var interact_map: Dictionary
var next_interact_script: Node

onready var can_interact = true

func add_interact_script(script):
	interact_map[script] = true
	next_interact_script = script

func remove_interact_script(script):
	var _script_existed = interact_map.erase(script)

	if next_interact_script == script:
		if interact_map.keys().size() > 0:
			next_interact_script = interact_map.keys()[0]
		else:
			next_interact_script = null
