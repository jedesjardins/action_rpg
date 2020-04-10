tool
extends Area2D

class_name ChildArea

var logical_parent: Node setget set_logical_parent, get_logical_parent

func set_logical_parent(parent_node: Node):
	logical_parent = parent_node

func get_logical_parent() -> Node:
	return logical_parent
