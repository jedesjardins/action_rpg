
class_name Zone
extends Node2D

const CURRENT_ROOM = 0
const LAST_ROOM = 1

var visible_loaders: Dictionary
var entities_current_rooms: Dictionary # maps entity path -> RoomLoader?
var entities_in_rooms: Dictionary # maps Roomloader -> Array(Entity Path)

var Log = Logger.SubLogger.new(Logger.Level.TRACE, "zone.gd")

func _ready():
	for child in get_children():
		if child is RoomLoader:
			visible_loaders[child] = []
			entities_in_rooms[child] = []
			child.connect("make_active", self, "on_RoomLoader_make_active")
			child.connect("make_inactive", self, "on_RoomLoader_make_inactive")

#
# Room Loading Functions
#

func on_RoomLoader_make_active(active_loader):
	Log.trace("making %s active" % active_loader, "on_RoomLoader_make_active(active_loader)")
	make_room_visible_from(active_loader, active_loader)

	for visible_loader_path in active_loader.visible_room_loaders:
		var newly_visible_loader = active_loader.get_node(visible_loader_path)
		make_room_visible_from(newly_visible_loader, active_loader)

func make_room_visible_from(newly_visible, active_loader):
	assert(visible_loaders.has(newly_visible))
	visible_loaders[newly_visible].push_back(active_loader)

	if not newly_visible.room_is_loaded():
		Log.trace("Loading newly visible loader: %s" % newly_visible, "make_room_visible_from(newly_visible, active_loader)")
		newly_visible.call_deferred("load_room")

func on_RoomLoader_make_inactive(inactive_loader):
	Log.trace("making %s inactive" % inactive_loader, "on_RoomLoader_make_active(active_loader)")

	for loader in visible_loaders:
		# get the list of active loaders keeping loader alive
		var reference_list = visible_loaders[loader]

		# remove inactive_loader from keep_alive list
		# (by swapping with the back, then popping back)

		Global.swap_and_pop_back(reference_list, inactive_loader)
		if reference_list.size() == 0:
			loader.call_deferred("unload_room")
			unload_entities_in_room(loader)

#
# Entity Room functions
#

func add_entity_to_room(entity, roomloader):
	Log.trace("adding entity %s to room %s" % [entity, roomloader], "on_RoomLoader_make_active(active_loader)")

	var entity_path = entity.get_path()

	# update the entities room pair
	if not entities_current_rooms.has(entity_path):
		# add the entity for the first time to roomloader
		entities_current_rooms[entity_path] = [roomloader, null]
	else:
		# move the entity to the new room
		var room_pair = entities_current_rooms[entity_path]

		# don't double add an entity to the room (will duplicate it in it's entity list)
		assert(room_pair[CURRENT_ROOM] != roomloader)

		room_pair[LAST_ROOM] = room_pair[CURRENT_ROOM]
		room_pair[CURRENT_ROOM] = roomloader

	# update rooms entity list
	entities_in_rooms[roomloader].push_back(entity_path)

func remove_entity_from_room(entity, roomloader, delete_when_leaving = true):
	Log.trace("removing entity %s from room %s" % [entity, roomloader], "remove_entity_from_room(entity, roomloader, delete_when_leaving)")

	var entity_path = entity.get_path()

	# entity must have had it's room_pair added to be removed (logical error)
	assert(entities_current_rooms.has(entity_path))

	var room_pair = entities_current_rooms[entity_path]

	if room_pair[CURRENT_ROOM] == roomloader:
		# make the last room the current room
		room_pair[CURRENT_ROOM] = room_pair[LAST_ROOM]

		if delete_when_leaving and room_pair[CURRENT_ROOM] == null:
			Log.debug("deleting entity %s because it is not in a room" % entity, "remove_entity_from_room(entity, roomloader, delete_when_leaving)")

			var _erase_result = entities_current_rooms.erase(entity_path)
			entity.queue_free()

	room_pair[LAST_ROOM] = null

	# remove the entity from the rooms list of entities
	var entities_in_room = entities_in_rooms[roomloader]
	Global.swap_and_pop_back(entities_in_room, entity_path)

func unload_entities_in_room(roomloader):
	Log.trace("unload all entities from room %s" % roomloader, "unload_entities_in_room(roomloader)")

	var entities_in_current_room = entities_in_rooms[roomloader]

	# for each entity in roomloader
	for entity_path in entities_in_current_room:
		var entity = get_node(entity_path)

		Log.debug("unloading entity %s" % entity, "unload_entities_in_room(roomloader)")

		# delete the entity
		entity.queue_free()

		# for each other room this entity is in
		for room in entities_current_rooms[entity_path]:
			if room != roomloader and room != null: # since last_room can be null!
				Log.trace("removing entity %s from room %s" % [entity, room], "unload_entities_in_room(roomloader)")
				# remove the entity from the other room too (it was on a border)
				Global.swap_and_pop_back(entities_in_rooms[room], entity_path)

	entities_in_current_room.clear()


