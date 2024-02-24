extends Node

signal new_message(message: String)

func displayMessage(message):
	new_message.emit(message)
