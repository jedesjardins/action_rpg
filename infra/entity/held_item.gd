extends Node2D

class_name HeldItem

export var sprite_path: NodePath
var sprite: Sprite

func _ready():
	sprite = get_node(sprite_path)

func set_direction(direction: int): # pass in direction enum
	match direction:
		Helpers.Direction.DOWN:
			sprite.frame = 0
		Helpers.Direction.DOWN_RIGHT:
			sprite.frame = 1
		Helpers.Direction.RIGHT:
			sprite.frame = 2
		Helpers.Direction.UP_RIGHT:
			sprite.frame = 3
		Helpers.Direction.UP:
			sprite.frame = 4
		Helpers.Direction.UP_LEFT:
			sprite.frame = 5
		Helpers.Direction.LEFT:
			sprite.frame = 6
		Helpers.Direction.DOWN_LEFT:
			sprite.frame = 7
