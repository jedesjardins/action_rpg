extends Area2D

class_name ChildArea

var parent: Node setget set_logical_parent, get_logical_parent

func set_logical_parent(parent_node: Node):
	parent = parent_node

func get_logical_parent() -> Node:
	return parent
