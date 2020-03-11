
extends InteractScript

func interact():
	print("Interacted!!")

func trigger_entered(body):
	if body.is_in_group("player") and body != ignored_node:
		$"..".get_physics_body().get_appearance().highlight()
		body.get_parent().behavior_body.add_interact_script(self)

func trigger_exited(body):
	if body.is_in_group("player") and body != ignored_node:
		$"..".get_physics_body().get_appearance().unhighlight()
		body.get_parent().behavior_body.remove_interact_script(self)
