

tool
extends TriggerScript

class_name InteractScript

func interact(_initiator):
	assert(false)

func is_interacting() -> bool:
	assert(false)

	return false

func trigger_entered(_body):
	assert(false)

	# example of how one might interact with the player
#	if body.is_in_group("player") and body != ignored_node:
#		$"..".get_entity().get_appearance().highlight()
#		body.get_parent().behavior_body.add_interact_script(self)

func trigger_exited(_body):
	assert(false)

#	if body.is_in_group("player") and body != ignored_node:
#		player_exited_trigger = true
#		$"..".get_entity().get_appearance().unhighlight()
#		body.get_parent().behavior_body.remove_interact_script(self)
