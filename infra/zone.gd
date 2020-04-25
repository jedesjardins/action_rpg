extends Node2D

# children are Room Loaders
# there needs to be the concept of a current room

var visible_loaders: Dictionary

func _ready():
	for child in get_children():
		if child is RoomLoader:
			visible_loaders[child] = []
			child.connect("make_active", self, "make_room_loader_active")
			child.connect("make_inactive", self, "make_room_loader_inactive")

func make_room_loader_active(active_loader):
	make_room_visible_from(active_loader, active_loader)

	for visible_loader_path in active_loader.visible_room_loaders:
		var newly_visible_loader = active_loader.get_node(visible_loader_path)
		make_room_visible_from(newly_visible_loader, active_loader)

func make_room_visible_from(newly_visible, active_loader):
	assert(visible_loaders.has(newly_visible))
	visible_loaders[newly_visible].push_back(active_loader)

	if not newly_visible.room_is_loaded():
		print("Loading: ", newly_visible.get_path())
		newly_visible.call_deferred("load_room")

func make_room_loader_inactive(inactive_loader):
	for loader in visible_loaders:
		# get the list of active loaders keeping loader alive
		var reference_list = visible_loaders[loader]

		# remove inactive_loader from keep_alive list
		# (by swapping with the back, then popping back)
		var il_index = reference_list.find(inactive_loader)
		if il_index != -1:
			if il_index != reference_list.size() - 1:
				reference_list[il_index] = reference_list[reference_list.size() - 1]

			reference_list.pop_back()

			if reference_list.size() == 0:
				loader.call_deferred("unload_room")
