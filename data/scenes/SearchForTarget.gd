extends State

@export var team_id: int = 0
@export var game_map: GameMap2D

signal target_found(target: DamageTarget2D)
signal no_target_found

var enabled = false

func _enter_state() -> void:
	enabled = true

func _exit_state() -> void:
	enabled = false

func _physics_process(delta: float) -> void:
	if !enabled:
		return
	
	var potentialTargets = get_tree().get_nodes_in_group("DamageTarget");
	
	var target = null
	for item in potentialTargets:
		var convertedItem = item as DamageTarget2D
		
		if convertedItem.team_id == team_id:
			continue;
			
		if !game_map.isVisible(convertedItem.global_position):
			continue;
		
		# TODO - Distance Check - prioritise closer?
		
		target = convertedItem
		
	if target != null:
		target_found.emit(target)	
	elif target == null:
		no_target_found.emit()
		
