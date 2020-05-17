extends Node

enum Level {
	TRACE,
	DEBUG,
	INFO,
	WARN,
	ERROR,
	NONE
}

const LOG_STRINGS = ["TRACE", "DEBUG", "INFO", "WARN", "ERROR"]
const DEFAULT_LOG_PATH = "res://"
const DEFAULT_LOG_NAME = "logger"
const LOG_FORMAT = "[{current_time}] | {level} | [{script_name}] [{function_name}] >> {msg}"

var script_name_stack: Array
var function_name_stack: Array
onready var global_level = Level.TRACE
onready var global_sinks = [ConsoleSink.new(Level.ERROR), FileSink.new(Level.TRACE)]

func add_sink(sink):
	global_sinks.append(sink)

# Used to set script and function name at the beginning of each function,
# in order to populate the log lines
func start(script_name, function_name):
	script_name_stack.append(script_name)
	function_name_stack.append(function_name)

func end():
	script_name_stack.pop_back()
	function_name_stack.pop_back()

func trace(message, script_name = "", function_name = ""):
	_log(Level.TRACE, message, script_name, function_name)

func debug(message, script_name = "", function_name = ""):
	_log(Level.DEBUG, message, script_name, function_name)

func info(message, script_name = "", function_name = ""):
	_log(Level.INFO, message, script_name, function_name)

func warn(message, script_name = "", function_name = ""):
	_log(Level.WARN, message, script_name, function_name)

func error(message, script_name = "", function_name = ""):
	_log(Level.ERROR, message, script_name, function_name)

func _log(level, message, script_name = "", function_name = ""):
	if level < global_level:
		return

	if function_name.empty():
		script_name = script_name_stack.back()
	if function_name.empty():
		function_name = function_name_stack.back()

	var log_message = LOG_FORMAT.format({"level": LOG_STRINGS[level], "current_time": _get_current_time(), "script_name": script_name, "function_name": function_name, "msg": message})

	for sink in global_sinks:
			sink.write(level, log_message)

func _get_current_time():
	var date_time = OS.get_datetime()
	var padding = 2
	_pad_zeros_in_dictionary(date_time, padding)
	var time_format = "{year}-{month}-{day}"
	return time_format.format(date_time)

func _pad_zeros_in_dictionary(dictionary, padding):
	for key in dictionary:
		dictionary[key] = str(dictionary[key]).pad_zeros(padding)

class SubLogger:
	var local_level: int

	var local_script_name: String
	var local_function_name: String

	func _init(log_level: int, script_name: String):
		local_level = log_level
		self.local_script_name = script_name

	func start(function_name):
		local_function_name = function_name

	func end():
		local_function_name = ""
		
	func trace(message, function_name = ""):
		_log(Level.TRACE, message, function_name)
		
	func debug(message, function_name = ""):
		_log(Level.DEBUG, message, function_name)

	func info(message, function_name = ""):
		_log(Level.INFO, message, function_name)

	func warn(message, function_name = ""):
		_log(Level.WARN, message, function_name)
		
	func error(message, function_name = ""):
		_log(Level.ERROR, message, function_name)

	func _log(level, message, function_name = ""):
		if level < local_level:
			return

		if(function_name.empty()):
			function_name = local_function_name
		var log_message = LOG_FORMAT.format({"level": LOG_STRINGS[level], "current_time": Logger._get_current_time(), "script_name": local_script_name, "function_name": function_name, "msg": message})
		
		for sink in Logger.global_sinks:
			sink.write(level, log_message)

class FileSink:
	var level: int

	var file = null
	var full_file_path= ""

	func _init(min_log_level: int, file_path = DEFAULT_LOG_PATH, file_name = DEFAULT_LOG_NAME):
		level = min_log_level

		self.full_file_path = file_path  + Logger._get_current_time() + "-" + file_name + ".log"
		self.file = File.new()
		
		_create_file_if_not_exist()

	func _create_file_if_not_exist():
		if(!file.file_exists(full_file_path)):
			file.open(full_file_path, File.WRITE)
			file.close()

	func write(log_level: int, log_line: String):
		if log_level >= level:
			self.file.open(full_file_path, File.READ_WRITE)
			self.file.seek_end()
			self.file.store_line(log_line)
			self.file.close()


class ConsoleSink:
	var level: int

	func _init(min_log_level: int):
		level = min_log_level

	func write(log_level: int, log_line: String):
		if log_level >= level:
			print(log_line)
