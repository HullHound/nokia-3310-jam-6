extends Node
class_name DirectionInputMover2D

@export var target: Node2D
@export var bounds: Rect2
@export var movement_amount = 16
@export var enabled: bool = true

func _unhandled_key_input(event: InputEvent) -> void:
	if !enabled:
		return
		
	var newPosition = target.position
	
	if event.is_action_released("Up"):
		newPosition.y -= movement_amount
	elif event.is_action_released("Down"):
		newPosition.y += movement_amount
	elif event.is_action_released("Left"):
		newPosition.x -= movement_amount
	elif event.is_action_released("Right"):
		newPosition.x += movement_amount
		
	if bounds.has_point(newPosition):
		target.position = newPosition
