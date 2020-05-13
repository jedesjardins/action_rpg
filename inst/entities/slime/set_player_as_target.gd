extends BTNode

func tick(bb: Dictionary) -> int:
	var game_state = get_node(Global.get_root_path_of(self))
	bb.target = game_state.player

	return OK
