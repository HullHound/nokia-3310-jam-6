extends Control

signal restart_requested

func showScreen(messageText: String, buttonText:String):
	$MessageText.text = messageText
	$NinePatchRect2/ButtonText.text = buttonText
	self.visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_accept") && self.visible:
		restart_requested.emit()
