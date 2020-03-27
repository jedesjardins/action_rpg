tool
extends InteractScript

var player_exited_trigger = false

func trigger_entered(entity):
	if entity.is_in_group("player"):
		entity.emit_signal("entered_area", self, $"..".get_entity().get_appearance())
	
#	if entity.is_in_group("player") and entity != ignored_node and entity.behavior != null:
#		$"..".get_entity().get_appearance().highlight()
#		entity.behavior.add_interact_script(self)

func trigger_exited(entity):
	if entity.is_in_group("player"):
		entity.emit_signal("exited_area", self)
	
#	if entity.is_in_group("player") and entity != ignored_node and entity.behavior != null:
#		player_exited_trigger = true
#		$"..".get_entity().get_appearance().unhighlight()
#		entity.behavior.remove_interact_script(self)

func is_interacting() -> bool:
	return has_node("TextBox")

func interact(_initiator):
	if is_interacting():
		return
	
	player_exited_trigger = false
	
	var textbox_scene = load("res://inst/entities/textbox/textbox.tscn")
	var textbox = textbox_scene.instance()
	textbox.top_line_text = "Hello?"
	# set custom trigger
	textbox.set_trigger(funcref(self, "textbox_trigger"))
	add_child(textbox)
	textbox.position = Vector2(0.0, -16.0)
	
	yield(textbox, "text_shown")
	
	if player_exited_trigger:
		textbox.show_text("If you're just gonna walk away then...", "")
		yield(textbox, "text_shown")
		var timer = Timer.new()
		add_child(timer)
		timer.start(0.4)
		yield(timer, "timeout")
		textbox.queue_free()
		timer.queue_free()
		return
	
	textbox.show_text("What now? This is really long text, what", "will happen?")
	
	yield(textbox, "text_shown")
	
	textbox.queue_free()

# custom textbox trigger
func textbox_trigger():
	if Input.is_action_just_pressed('ui_accept') or player_exited_trigger:
		return true;
