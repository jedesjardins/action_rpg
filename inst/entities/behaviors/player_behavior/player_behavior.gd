
tool
extends BaseBehavior

var blackboard: Dictionary

var interact_map: Dictionary
var next_interact_script: Node

func _ready():
	blackboard.direction = Helpers.Direction.DOWN
	blackboard.direction_string = {
		Helpers.Direction.DOWN: "down",
		Helpers.Direction.DOWN_RIGHT: "right",
		Helpers.Direction.RIGHT: "right",
		Helpers.Direction.UP_RIGHT: "right",
		Helpers.Direction.UP: "up",
		Helpers.Direction.UP_LEFT: "left",
		Helpers.Direction.LEFT: "left",
		Helpers.Direction.DOWN_LEFT: "left"
	}

	blackboard.interacting = false
	blackboard.interact_map = interact_map
	blackboard.interactor = self

func set_entity(node: Node):
	if entity != null:
		entity.disconnect("entered_area", self, "entered_area")
		entity.disconnect("exited_area", self, "exited_area")
	
	.set_entity(node) # call inherited function, sets entity
	blackboard.entity = entity
	
	entity.hurtbox.connect("area_entered", self, "take_damage")
	
	var _err = entity.connect("entered_area", self, "entered_area")
	_err = entity.connect("exited_area", self, "exited_area")

func set_item(item):
	if item == null:
		var _ret = blackboard.erase("item")
	else:
		blackboard.item = item

func get_item():
	if blackboard.has("item"):
		return blackboard.item
	else:
		return null

func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	
	blackboard.delta = delta
	blackboard.next_interact_script = next_interact_script
	
	if Input.is_key_pressed(KEY_Q):
		entity.drop_item()
	
	$"BehaviorTree".tick(blackboard)

func add_interact_script(script, sprite):
	# unhighlight the last one
	if next_interact_script:
		var last_sprite = interact_map[next_interact_script]
		if last_sprite:
			last_sprite.unhighlight()
	
	# add and highlight the next
	interact_map[script] = sprite
	next_interact_script = script
	if sprite:
		sprite.highlight()

func remove_interact_script(script):
	if next_interact_script == script:
		var sprite = interact_map[script]
		if sprite:
			sprite.unhighlight()
	
	var _script_existed = interact_map.erase(script)
	
	if next_interact_script == script:
		if interact_map.keys().size() > 0:
			next_interact_script = interact_map.keys()[0]
			var next_sprite = interact_map[next_interact_script]
			if next_sprite:
				next_sprite.highlight()
		else:
			next_interact_script = null

func take_damage(area):
#	print("In take_damage from ", area.get_path())
	
	if area is ChildArea and area.parent != blackboard.item:
		print("Taken damage from ", area.get_parent().get_path())

func entered_area(area, sprite):
	add_interact_script(area, sprite)
#	if area is Weapon:
#		add_interact_script(area)
#		area.sprite.highlight()

func exited_area(area):
	remove_interact_script(area)
#	if area is Weapon:
#		remove_interact_script(area)
#		area.sprite.unhighlight()
