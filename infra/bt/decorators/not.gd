
class_name Not
extends Decorator

# negates OK to FAILED and vice versa, passes through ERR_BUSY
func tick(blackboard: Dictionary) -> int:
	assert(get_child_count() == 1)

	var result = get_children()[0].tick(blackboard)

	if result == ERR_BUSY:
		return ERR_BUSY
	elif result == OK:
		return FAILED
	else: # if result == FAILED:
		return OK

