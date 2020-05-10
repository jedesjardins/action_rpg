
class_name Selector
extends Composite

# runs children in order until one returns OK
# as soon as a child returns OK, it returns OK
# if a child returns FAILED, it continues processing it's children
# if a child returns ERR_BUSY, it immediately returns ERR_BUSY and will resume
# with that child next tick

var running_child: BTNode

func tick(blackboard: Dictionary) -> int:
	var start_index = 0
	var child_array = get_children()

	if running_child:
		start_index = running_child.get_index()
		running_child = null

	for i in range(start_index, child_array.size()):
		var child = child_array[i]
		assert(child is BTNode)

		var result = child.tick(blackboard)
		if result == OK:
			return OK
		if result == ERR_BUSY:
			running_child = child
			return ERR_BUSY

	return FAILED
