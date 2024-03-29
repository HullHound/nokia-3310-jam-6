extends State

var enabled = false

signal minePressed
signal buildPressed
signal slapPressed

func _enter_state() -> void:
	enabled = true

func _exit_state() -> void:
	enabled = false

func _input(event: InputEvent) -> void:
	if event.is_action_released("Mine"):
		minePressed.emit()
	
	if event.is_action_released("Build"):
		buildPressed.emit()
		
	if event.is_action_released("Slap"):
		slapPressed.emit()
