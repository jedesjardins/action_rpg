extends BaseBehavior

func _ready():
	pass # Replace with function body.

func set_physics_body(new_physics_body: Node):
	physics_body = new_physics_body
	var err = physics_body.get_node("Trigger").connect("body_entered", self, "body_entered")
	assert(err == OK)

func body_entered(body):
	if body != physics_body:
		if body.is_in_group("player"):
			print("Player Body Entered BaseEntity2 ", body.get_path())
