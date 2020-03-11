tool
extends BaseBehavior

#var item: Node
var interact_map = {}
var next_interacting_script: Node
var can_interact = true

func _ready():
	pass
	
	# called when the player hitbox enters another area
	# physics_body.get_hitbox().connect("area_entered", self, "add_interact_area")
	
	# called when the player hitbox leaves another area
	# physics_body.get_hitbox().connect("area_exited", self, "remove_interact_area")

func get_velocity():
	var velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1

	velocity = velocity.normalized() * 36
	
	return velocity

func _physics_process(_delta):
	if Engine.is_editor_hint():
		return
	
	if Input.is_action_just_pressed("ui_accept") and next_interacting_script and can_interact:
		enable_interaction_after(next_interacting_script)
	
	var velocity = get_velocity()

#	item = get_physics_body().get_node("Hand/Sprite")
	
	var animation_player = physics_body.get_node("AnimationPlayer")
	
	var modifier = 0
	
	if velocity.length() == 0:
		animation_player.play("stand")
		modifier = 1
#		if item:
#			physics_body.get_node("Hand/Sprite").frame = 0
	else:
		var next_animation: String
#		var frame = 0
		
		if velocity.x > 0:
			if velocity.y < 0:
				next_animation = "walk_up_right"
#				frame = 3
				modifier = -1
			else:
				next_animation = "walk_down_right"
#				frame = 1
				modifier = 1
		elif velocity.x < 0:
			if velocity.y < 0:
				next_animation = "walk_up_left"
#				frame = 5
				modifier = -1
			else:
				next_animation = "walk_down_left"
#				frame = 7
				modifier = 1
		else:
			if velocity.y > 0:
				next_animation = "walk_down"
#				frame = 0
				modifier = 1
			elif velocity.y < 0:
				next_animation = "walk_up"
#				frame = 4
				modifier = -1
				
		if not animation_player.current_animation == next_animation:
			animation_player.advance(0)
			animation_player.play(next_animation)
#			if item:
#				physics_body.get_node("Hand/Sprite").frame = frame
	
	physics_body.move_and_slide(velocity)
	
	for i in physics_body.get_slide_count():
		handle_physics_collision(physics_body.get_slide_collision(i))
	
	var z = physics_body.get_global_transform_with_canvas().get_origin().y
	
	physics_body.get_node("Sprite").z_index = z
	physics_body.get_node("Hand/Sprite").z_index = z + modifier

func handle_physics_collision(_info: KinematicCollision2D):
	pass

func add_interact_script(script):
#	print("Added area: ", script.get_path(), " to player interaction list")
	interact_map[script] = true
	next_interacting_script = script
#	print("Next interacting script ", next_interacting_script)

func remove_interact_script(script):
#	print("Removed area: ", script.get_path(), " from player interaction list")
	interact_map.erase(script)
	if next_interacting_script == script:
		if interact_map.keys().size() > 0:
			next_interacting_script = interact_map.keys()[0]
		else:
			next_interacting_script = null

#	print("Next interacting Area ", next_interacting_script)

func enable_interaction_after(script):
	can_interact = false
	script.interact()
	yield(script, "completed")
	print("Completed")
	can_interact = true
