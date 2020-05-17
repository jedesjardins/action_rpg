tool

class_name Suceed
extends Decorator

# always returns OK unless the child result is ERR_BUSY
func tick(blackboard: Dictionary) -> int:
	assert(get_child_count() == 1)

	var result = get_children()[0].tick(blackboard)

	if result == ERR_BUSY:
		return result

	return OK

