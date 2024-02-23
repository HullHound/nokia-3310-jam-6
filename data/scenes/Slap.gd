extends State

var enabled = false

@export var ray_cast_2d: RayCast2D
@export var damage_amount = 1
@export var game_map: GameMap2D
@export var team_id = 0

@export var minimum_time_between_slaps = 1.0

var time_since_last_slap = 1.0

signal finished

func _enter_state() -> void:
	enabled = true
	slap()

func _exit_state() -> void:
	enabled = false

func _physics_process(delta: float) -> void:
	time_since_last_slap += delta
	
	if !enabled:
		return

	finished.emit()	
	
func slap():
	if time_since_last_slap < minimum_time_between_slaps:
		return
	
	var collider = ray_cast_2d.get_collider()
	
	if collider == null:
		return

	if collider is DamageTarget2D:
		var target = collider as DamageTarget2D
		
		if target.team_id != team_id:
			return
		
		if !game_map.isVisible(target.global_position):
			return

		target.damage(damage_amount)
		time_since_last_slap = 0.0
