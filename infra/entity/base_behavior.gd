tool
extends Node

class_name BaseBehavior

var physics_body: Node setget set_physics_body, get_physics_body

func _ready():
	pass

func get_physics_body() -> Node:
	return physics_body

func set_physics_body(node: BasePhysicsBody):
	physics_body = node
