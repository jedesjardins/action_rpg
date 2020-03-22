extends Node2D

class_name Item

class AnimationStage:
	var item_animation: String
	var entity_animation: String
	var duration: float
	
	func _init(d: Dictionary):
		item_animation = d.item_animation
		entity_animation = d.entity_animation
		duration = d.duration

class AttackAnimation:
	var warmup_animation: AnimationStage
	var main_animation: AnimationStage
	var cooldown_animation: AnimationStage
	
	func _init(d: Dictionary):
		warmup_animation = AnimationStage.new(d.warmup)
		main_animation = AnimationStage.new(d.main)
		cooldown_animation = AnimationStage.new(d.cooldown)

export var json_path: String
var attack_animations: Dictionary

func _ready():
	var file = File.new()
	assert(file.file_exists(json_path))
	file.open(json_path, 1)
	var parse_result = JSON.parse(file.get_as_text())
	assert(parse_result.error == OK)
	
	var parsed_dict = parse_result.result
	
	print(parsed_dict)
	
	assert(parsed_dict.has("attacks"))
	var attacks = parsed_dict.attacks
	for key in parsed_dict.attacks.keys():
		var aa = AttackAnimation.new(attacks[key])
		attack_animations[key] = aa
