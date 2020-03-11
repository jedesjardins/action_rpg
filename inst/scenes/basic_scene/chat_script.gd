tool
extends InteractScript

var player_exited_trigger = false

func trigger_entered(body):
	if body.is_in_group("player") and body != ignored_node:
		$"..".get_physics_body().get_appearance().highlight()
		body.get_parent().behavior_body.add_interact_script(self)

func trigger_exited(body):
	if body.is_in_group("player") and body != ignored_node:
		player_exited_trigger = true
		$"..".get_physics_body().get_appearance().unhighlight()
		body.get_parent().behavior_body.remove_interact_script(self)

func interact():
	if has_node("TextBox"):
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
