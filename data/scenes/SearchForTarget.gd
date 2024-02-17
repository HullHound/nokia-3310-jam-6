extends State

@export var team_id: int = 0
@export var fog_of_war: TileMap

signal target_found(target: DamageTarget2D)

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
			
		if fog_of_war.get_cell_source_id(0, fog_of_war.local_to_map(convertedItem.global_position)) != -1:
			continue;
		
		# TODO - Distance Check - prioritise closer?
		
		target = convertedItem
		
	if target != null:
		target_found.emit(target)	
