extends State

var enabled = false

signal build
signal canceled

@export var build_place_holder: BuildPlaceholder

func _enter_state() -> void:
	enabled = true
	build_place_holder.visible = true

func _exit_state() -> void:
	enabled = false	
	build_place_holder.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_released("Cancel"):
		canceled.emit()
	
	if event.is_action_released("Confirm"):
		build.emit()
