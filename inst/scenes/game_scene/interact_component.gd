
extends Node

var interact_map: Dictionary
var next_interact_script: Node

onready var can_interact = true

func add_interact_script(script, sprite):
	# unhighlight the last one
	if next_interact_script:
		var last_sprite = interact_map[next_interact_script]
		if last_sprite:
			last_sprite.unhighlight()

	# add and highlight the next
	interact_map[script] = sprite
	next_interact_script = script
	if sprite:
		sprite.highlight()

func remove_interact_script(script):
	if next_interact_script == script:
		var sprite = interact_map[script]
		if sprite:
			sprite.unhighlight()

	var _script_existed = interact_map.erase(script)

	if next_interact_script == script:
		if interact_map.keys().size() > 0:
			next_interact_script = interact_map.keys()[0]
			var next_sprite = interact_map[next_interact_script]
			if next_sprite:
				next_sprite.highlight()
		else:
			next_interact_script = null
