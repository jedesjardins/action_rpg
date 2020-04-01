tool
extends ChildPhysicsBody # extends KinematicBody2D

class_name Entity

export var appearance_path: NodePath
var appearance: Node

export var trigger_path: NodePath
var trigger: Area2D

export var hitbox_path: NodePath
var hitbox: Area2D

export var hurtbox_path: NodePath
var hurtbox: Area2D

export var hand_path: NodePath
var hand: Node2D

export var behavior_path: NodePath
var behavior: BaseBehavior

var direction: int
var action: int

func _ready():
	if trigger_path:
		trigger = get_node(trigger_path)
	
	if appearance_path:
		appearance = get_node(appearance_path)
	
	if hitbox_path:
		hitbox = get_node(hitbox_path)
		assert(hitbox is ChildArea)
		hitbox.logical_parent = self
	
	if hurtbox_path:
		hurtbox = get_node(hurtbox_path)
		assert(hurtbox is ChildArea)
		hurtbox.logical_parent = self
	
	if behavior_path:
		behavior = get_node(behavior_path)
		behavior.set_entity(self)

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

func has_behavior() -> bool:
	return behavior != null

func get_behavior() -> Node:
	return behavior

func hold_item(var item_node: Weapon):
	assert(item_node)
	
	if has_node("Hand"):
		
		var hand = get_node("Hand")
		
		# delete the old transform if there was one
		if hand.has_node("item_transform"):
			hand.get_node("item_transform").queue_free()

		if behavior:
			behavior.set_item(item_node)
		
		var remote_transform = RemoteTransform2D.new()
		remote_transform.name = "item_transform"
		hand.add_child(remote_transform, true)
		remote_transform.remote_path = Helpers.get_relative_path_from(remote_transform, item_node)
		
		item_node.held_by(self)

func drop_item():
	if has_node("Hand"):
		var hand = get_node("Hand")
		if hand.has_node("item_transform"):
			print("Freeing the Item RemoteTransform2D")
			var item_transform = hand.get_node("item_transform")
			
			hand.remove_child(item_transform)
			item_transform.queue_free()
	
	var held_item = behavior.get_item()
	if held_item:
		held_item.drop()
		behavior.set_item(null)
