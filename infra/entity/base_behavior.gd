tool

class_name BaseBehavior
extends Node2D

var entity: Node setget set_entity, get_entity

func _ready():
	pass

func get_entity() -> Node:
	return entity

func set_entity(node: Node):
	entity = node
