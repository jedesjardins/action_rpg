extends BTNode

func tick(bb: Dictionary) -> int:
	if not bb.has("busy"):
		bb.busy = true
		return ERR_BUSY
	else:
		var _err = bb.erase("busy")
		return OK
