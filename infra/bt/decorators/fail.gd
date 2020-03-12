extends Decorator

# always returns FAILED unless the child result is ERR_BUSY
class_name Fail

func tick(blackboard: Dictionary) -> int:
	assert(get_child_count() == 1)
	
	var result = get_children()[0].tick(blackboard)
	
	if result == ERR_BUSY:
		return result
	
	return FAILED
