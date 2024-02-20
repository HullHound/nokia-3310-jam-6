extends State

var enabled = false

@export var ray_cast_2d: RayCast2D
@export var damage_amount = 1

signal finished

func _enter_state() -> void:
	enabled = true
	slap()

func _exit_state() -> void:
	enabled = false

func _input(event: InputEvent) -> void:
	if !enabled:
		return

	finished.emit()
	
func slap():
	var collider = ray_cast_2d.get_collider()
	
	if collider == null:
		return
		
	if collider is DamageTarget2D:
		var target = collider as DamageTarget2D
		target.damage(damage_amount)
