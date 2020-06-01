
extends Area2D

func _ready():
	var _err = get_parent().connect("ready", self, "on_Parent_ready")

	_err = connect("body_entered", self, "on_Trigger_body_entered")
	_err = connect("body_exited", self, "on_Trigger_body_exited")

func on_Parent_ready():
	var _err = get_parent().connect("ready", self, "body_entered")

func on_Trigger_body_entered(body):
	if body.is_in_group("player") and body.has_node("Interact"):
		body.get_node("Interact").add_interact_script(self)

func on_Trigger_body_exited(body):
	if body.is_in_group("player") and body.has_node("Interact"):
		body.get_node("Interact").remove_interact_script(self)

func interact_with(entity):
	if entity.has_node("Hand"):
		Logger.debug("Remove Item interact script!", "item_pickup_trigger.gd", "interact_with(entity)")
		entity.get_node("Interact").remove_interact_script(self)
		entity.get_node("Hand").hold_item(self.get_parent())

		get_parent().emit_signal("picked_up")
		$"CollisionShape2D".disabled = true

func is_interacting() -> bool:
	return false