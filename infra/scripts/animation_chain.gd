extends Node

# TODO: remove this

class_name AnimationChain

signal finished

var animation_player: AnimationPlayer
var is_interrupted = false
var is_playing = false
var current_animation

func _init(ap: AnimationPlayer):
	animation_player = ap

	var err = animation_player.connect("animation_started", self, "on_AnimationPlayer_animation_started")
	if err:
		print("Error initializing AnimationChain")

func on_AnimationPlayer_animation_started(new_animation: String):
	if is_playing and new_animation != current_animation:
		print("interrupted by ", new_animation)
		is_interrupted = true
		is_playing = false

func run(animations: PoolStringArray, durations: PoolRealArray, direction):
	assert(not is_playing)
	assert(durations != null)

	is_playing = true
	is_interrupted = false

	if animation_player.current_animation == animations[0]:
		animation_player.seek(0, true)

	for i in range(animations.size()):
		var animation_name = animations[i] + direction
		current_animation = animation_name
		
		var time_scale = animation_player.get_animation(animation_name).length / durations[i]
		
		animation_player.play(animation_name, -1, time_scale)
		
		yield(animation_player, "animation_finished")
		
		if is_interrupted:
			print("Animation chain interrupted, not finishing!")
			#is_playing = false
			#emit_signal("finished")
			return

	is_playing = false
	emit_signal("finished")
