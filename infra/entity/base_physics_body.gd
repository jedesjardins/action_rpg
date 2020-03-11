tool
extends KinematicBody2D

class_name BasePhysicsBody

export var appearance_path: NodePath
var appearance: Node

export var trigger_path: NodePath
var trigger: Node

export var hitbox_path: NodePath
var hitbox: Node

export var hurtbox_path: NodePath
var hurtbox: Node

export var hand_path: NodePath
var hand: Node

func _ready():
	if trigger_path:
		trigger = get_node(trigger_path)
	
	if appearance_path:
		appearance = get_node(appearance_path)
	
	if hitbox_path:
		hitbox = get_node(hitbox_path)
	
	if hurtbox_path:
		hurtbox = get_node(hurtbox_path)

func has_trigger() -> bool:
	return trigger != null

func get_trigger() -> Node:
	return trigger
	
func has_hitbox() -> bool:
	return hitbox != null

func get_hitbox() -> Node:
	return hitbox

func has_hurtbox() -> bool:
	return hurtbox != null

func get_hurtbox() -> Node:
	return hurtbox

func has_appearance() -> bool:
	return appearance != null

func get_appearance() -> Node:
	return appearance
