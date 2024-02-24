extends Node

@export var no_message_gap_window = 30.0

var time_since_last_message = 0.0
var sent_no_message_signal = false

signal new_message(message: String)
signal no_message_gap

func displayMessage(message):
	new_message.emit(message)
	time_since_last_message = 0.0
	sent_no_message_signal = false

func _physics_process(delta: float) -> void:
	time_since_last_message += delta
	
	if time_since_last_message >= no_message_gap_window:
		sent_no_message_signal = true
		no_message_gap.emit()	

