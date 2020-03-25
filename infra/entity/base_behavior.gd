tool
extends Node2D

class_name BaseBehavior

var entity: Node setget set_entity, get_entity

func _ready():
	pass

func get_entity() -> Node:
	return entity

func set_entity(node: Node):
	entity = node
