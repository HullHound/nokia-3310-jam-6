extends State

@export var attack_delay: float = 1.0
@export var attack_range: float = 9.0
@export var damage_amount: float = 1.0

var target: DamageTarget2D
var enabled = false
var time_since_last_attack = 0.0

signal finished

func _enter_state() -> void:
	enabled = true
	attack()	

func _exit_state() -> void:
	enabled = false

func _physics_process(delta: float) -> void:
	if !enabled:
		return;
		
	time_since_last_attack += delta;
	
	if time_since_last_attack >= attack_delay:		
		finished.emit()

func set_target(new_target: DamageTarget2D):
	target = new_target

func attack():
	if target != null:
		target.damage(damage_amount)
	time_since_last_attack = 0.0
