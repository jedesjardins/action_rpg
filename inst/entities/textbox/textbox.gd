tool
extends Node2D

const MAX_CHAR_LINE_WIDTH = 44
const TEXT_SPEED = 10 # letters per second

export var top_line_text: String
export var bottom_line_text: String

var top_line_label: Node
var bottom_line_label: Node
var ellipsis_label: Node

var accumulated_time = 0
var top_line_split: PoolStringArray
var bottom_line_split: PoolStringArray
var current_line = 0
var current_split = 0
var next_char = 0

enum TextState {NONE, SHOWING_TEXT, WAITING_TO_FINISH, FINISHED}
var state = TextState.NONE

var trigger: FuncRef

class Triggers:
	
	static func on_enter_pressed():
		return Input.is_action_just_pressed('ui_accept')

signal text_shown

func show_text(top: String, bottom: String):
	assert(top.length() <= MAX_CHAR_LINE_WIDTH)
	assert(bottom.length() <= MAX_CHAR_LINE_WIDTH)
	
	top_line_text = top
	bottom_line_text = bottom
	
	top_line_split = top_line_text.split(" ", false)
	bottom_line_split = bottom_line_text.split(" ", false)
	
	accumulated_time = 0
	current_line = 0
	current_split = 0
	next_char = 0
	
	state = TextState.SHOWING_TEXT
	
	top_line_label.set_text("")
	bottom_line_label.set_text("")
	ellipsis_label.set_text("")
	
	set_process(true)

func set_trigger(new_trigger: FuncRef):
	trigger = new_trigger

func _ready():
	top_line_label = $"MarginContainer/MarginContainer/VBoxContainer/TopLine"
	bottom_line_label = $"MarginContainer/MarginContainer/VBoxContainer/BottomLine"
	ellipsis_label = $"Ellipsis"
	
	show_text(top_line_text, bottom_line_text)
	if not trigger:
		trigger = funcref(Triggers, "on_enter_pressed")
	
func _get_configuration_warning():
	if top_line_text.length() > MAX_CHAR_LINE_WIDTH:
		return "The top line of text should be less than " + String(MAX_CHAR_LINE_WIDTH) + " characters long.\nIt is currently " + String(top_line_text.length())
	
	if bottom_line_text.length() > MAX_CHAR_LINE_WIDTH:
		return "The bottom line of text should be less than " + String(MAX_CHAR_LINE_WIDTH) + " characters long.\nIt is currently " + String(bottom_line_text.length())
	
	return ""

func get_current_line():
	if current_line == 0:
		return top_line_split
	elif current_line == 1:
		return bottom_line_split
	else:
		return null

func get_current_split():
	var splits = get_current_line()
	if splits == null or current_split > splits.size() or splits.size() == 0:
		return null
	else:
		return splits[current_split]

func advance_split() -> bool: # returns true if you should append a space
	current_split += 1
	var splits = get_current_line()
	if current_split >= splits.size():
		current_split = 0
		current_line += 1
		return false
	return true

func add_to_labels(string: String):
	var current_label: Node
	
	if current_line == 0:
		current_label = top_line_label
	else:
		current_label = bottom_line_label
	
	current_label.set_text(current_label.text + string)

func reveal_text(delta):
	accumulated_time += delta
	
	var text_speed_scale = 1 
	if Input.is_action_pressed("ui_accept"):
		text_speed_scale = 2
	
	var reveal_characters_float = accumulated_time * TEXT_SPEED * text_speed_scale
	
	if reveal_characters_float >= 1:
		var reveal_characters = floor(reveal_characters_float)
		accumulated_time -= reveal_characters / (TEXT_SPEED * text_speed_scale)
		
		while reveal_characters > 0:
			var split = get_current_split() # string representing the current word
		
			if split == null:
				state = TextState.WAITING_TO_FINISH
				accumulated_time = 0
				break # yah done
			
			var substr_length = reveal_characters
			
			# if we display past the end of the string, cap at the current_string
			if next_char + substr_length > split.length():
				substr_length = split.length() - next_char
			
			var last_char = next_char
			reveal_characters -= substr_length
			next_char += substr_length
			
			var append_string = split.substr(last_char, substr_length)
			add_to_labels(append_string)

			if next_char == split.length():
				next_char = 0
				var add_space = advance_split()
				if add_space:
					add_to_labels(" ")

func _process(delta):
	match state:
		TextState.NONE:
			pass
		TextState.SHOWING_TEXT:
			reveal_text(delta)
		TextState.WAITING_TO_FINISH:
			if trigger and trigger.call_func():
				state = TextState.FINISHED
				return
			
			accumulated_time += delta
			var ellipses_shown = (int(floor(accumulated_time)) % 3) + 1
			if ellipses_shown != ellipsis_label.text.length():
				ellipsis_label.set_text(".".repeat(ellipses_shown))
		TextState.FINISHED:			
			state = TextState.NONE
			ellipsis_label.set_text("")
			set_process(false)
			emit_signal("text_shown")
