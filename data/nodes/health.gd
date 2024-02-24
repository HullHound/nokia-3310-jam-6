extends Node
class_name Health

@export var max_health = 5.0
var current_health = 5.0

signal health_changed(change_amount: float)
signal died()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health

func decrement_health(amount:float):
	current_health -= amount
	
	health_changed.emit(-amount)
	
	if current_health <= 0.0:
		died.emit()

func get_health():
	return current_health
