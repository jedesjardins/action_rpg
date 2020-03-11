tool
extends Node2D

class_name BaseBehavior

var physics_body: Node setget set_physics_body, get_physics_body

func _ready():
	pass

func get_physics_body() -> Node:
	return physics_body

func set_physics_body(node: BasePhysicsBody):
	if physics_body:
		physics_body.get_node("behavior_transform").queue_free()
		print("Resetting Physics Body hasn't been tested yet")
		# remove the previous remote transform
	
	physics_body = node
	
	# add remote transform for behavior_body to track physics_body
	var remote_transform = RemoteTransform2D.new()
	remote_transform.name = "behavior_transform"
	physics_body.add_child(remote_transform, true)
	remote_transform.remote_path = Helpers.get_relative_path_from(remote_transform, self)
