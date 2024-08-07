extends State

@export var team_id: int = 0
@export var game_map: GameMap2D
@export var agent: Node2D

signal target_found(target: DamageTarget2D)
signal no_target_found

var enabled = false

func _enter_state() -> void:
	enabled = true

func _exit_state() -> void:
	enabled = false

func _physics_process(_delta: float) -> void:
	if !enabled:
		return
	
	var potentialTargets = get_tree().get_nodes_in_group("DamageTarget");
	
	var target = null
	var distanceToTarget = 9999999999999999
	for item in potentialTargets:
		var convertedItem = item as DamageTarget2D
		
		if convertedItem.team_id == team_id:
			continue;
			
		if !game_map.isVisible(convertedItem.global_position):
			continue;
			
		if !game_map.getPathAdjacentTo(agent.global_position, convertedItem.global_position):
			continue
		
		var current_manhatten_distance = abs(convertedItem.global_position.x - agent.global_position.x) + abs(convertedItem.global_position.y - agent.global_position.y)
		
		if  current_manhatten_distance > distanceToTarget: # Pick the closer one
			continue
			
		if current_manhatten_distance == 0: # Don't target self
			continue
		
		target = convertedItem
		distanceToTarget = current_manhatten_distance
		
	if target != null:
		target_found.emit(target)	
	elif target == null:
		no_target_found.emit()
		
