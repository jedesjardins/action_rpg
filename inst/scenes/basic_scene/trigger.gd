extends Area2D

func _ready():
	var err = connect("body_entered", self, "start_script")
	if err != OK:
		print(err)

func start_script(_body):
	if has_node("TextBox"):
		return
	var textbox_scene = load("res://scenes/entities/textbox/textbox.tscn")
	var textbox = textbox_scene.instance()
	textbox.top_line_text = "Hello?"
	#textbox.set_trigger(funcref(self, "trigger"))

	add_child(textbox)
	
	yield(textbox, "text_shown")
	
	textbox.show_text("What now? This is really long text, what", "will happen?")
	
	yield(textbox, "text_shown")
	
	textbox.queue_free()

func trigger():
	return true
