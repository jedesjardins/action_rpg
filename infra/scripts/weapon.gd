
class_name Weapon
extends Node2D

#warning-ignore: unused_signal
signal picked_up
#warning-ignore: unused_signal
signal dropped

export var configuration_path: String

var configuration: Dictionary
var icon: String

func _ready():
	if Engine.is_editor_hint():
		return

	var file = File.new()
	assert(file.file_exists(configuration_path))
	file.open(configuration_path, 1)
	var parse_result = JSON.parse(file.get_as_text())
	assert(parse_result.error == OK)

	configuration = parse_result.result

	icon = configuration.icon
