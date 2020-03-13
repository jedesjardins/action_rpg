extends Decorator

# returns ERR_BUSY until child returns FAILED, in which case it returns OK
class_name Repeat

func tick(blackboard: Dictionary) -> int:
	assert(get_child_count() == 1)
	
	var result = get_children()[0].tick(blackboard)
	
	if result == FAILED:
		return OK
	else:
		return ERR_BUSY
