extends Node

class_name AnimationChain

signal finished

var animation_player: AnimationPlayer
var is_interrupted = false
var is_playing = false
var current_animation

func _init(ap: AnimationPlayer):
	animation_player = ap
	
	var err = animation_player.connect("animation_started", self, "interrupt")
	if err:
		print("Error initializing AnimationChain")

func interrupt(new_animation: String):
	if is_playing and new_animation != current_animation:
		print("interrupted by ", new_animation)
		is_interrupted = true
		is_playing = false

func run(animations: PoolStringArray, time_scales = null):
	assert(not is_playing)
	
	is_playing = true
	is_interrupted = false
	
	if not time_scales:
		time_scales = []
		time_scales.resize(animations.size())
		for time_scale in time_scales:
			time_scale = 1
		
		print(time_scales) 
	
	if animation_player.current_animation == animations[0]:
		animation_player.seek(0, true)
	
	for i in range(animations.size()):
		var animation_name = animations[i]
		
		current_animation = animation_name
		
		animation_player.play(animation_name, -1, time_scales[i])
		
		yield(animation_player, "animation_finished")
		
		if is_interrupted:
			print("Animation chain interrupted, not finishing!")
			#is_playing = false
			#emit_signal("finished")
			return
	
	is_playing = false
	emit_signal("finished")
