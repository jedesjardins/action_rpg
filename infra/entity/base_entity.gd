tool
extends Node2D

class_name BaseEntity

export(PackedScene) var physics_body_scene
export(PackedScene) var behavior_body_scene
export(NodePath) var physics_body_path
export(NodePath) var behavior_body_path

var physics_body: BasePhysicsBody
var behavior_body: BaseBehavior

#func _init(physics_body_scene_path, behavior_body_scene_path):
#	physics_body_scene = load(physics_body_scene_path)
#	behavior_body_scene = load(behavior_body_scene_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	# set physics_body node as either the instance of the scene, or the node
	# denoted by physics_body_path
	if physics_body_path:
		physics_body = get_node(physics_body_path)
	elif physics_body_scene:
		physics_body = physics_body_scene.instance()
		add_child(physics_body)
		physics_body_path = physics_body.get_path()
	
	# set behavior_body node as either the instance of the scene, or the node
	# denoted by behavior_body_path
	if behavior_body_path:
		behavior_body = get_node(behavior_body_path)
	elif behavior_body_scene:
		behavior_body = behavior_body_scene.instance()
		add_child(behavior_body)
		behavior_body_path = behavior_body.get_path()
	
	behavior_body.set_physics_body(physics_body)

func _get_configuration_warning():
	#if physics_body_path and physics_body_scene:
	#	return "Only one of physics_body_path or physics_body_scene may be set."
	
	if not physics_body_path and not physics_body_scene:
		return "One of physics_body_path or physics_body_scene must be set."
	
	#if behavior_body_path and behavior_body_scene:
	#	return "Only one of behavior_body_path or behavior_body_scene may be set."
	
	if not behavior_body_path and not behavior_body_scene:
		return "One of behavior_body_path or behavior_body_scene must be set."
	
	return ""

func hold_item(var item_node: Node):
	var hand = physics_body.get_node("Hand")
	
	if hand:
		# set item_node to track physics_body hand
		var remote_transform = RemoteTransform2D.new()
		hand.add_child(remote_transform)
		remote_transform.remote_path = Helpers.get_relative_path_from(remote_transform, item_node)
		
		# if item_node has a collider
		# 	add this entities collider to be ignored??? (which entity will it collide with???)
