extends State

@export var agent: Node2D
@export var game_map: GameMap2D

signal target_found(target: Vector2)
signal no_target_found

var enabled = false
@export var search_property = "couldBeClaimed_Player"
@export var neighbour_property = "claimedPlayer"

func _enter_state() -> void:
	enabled = true

func _exit_state() -> void:
	enabled = false



func _physics_process(_delta: float) -> void:
	if !enabled:
		return
	
	pick_claim_target()
	
func pick_claim_target():
	var potentialTargets: Array[Vector2] = game_map.getTilesWithProperty(search_property)
	potentialTargets.shuffle()
	
	var target = null
	var distanceToTarget = 9999999999999999
	for item in potentialTargets:
		#if !game_map.isVisible(item):
		#	continue;
		
		# Check Connected to a currently Claimed Tile
		var adjacent_to_claimed_tile = false
		var surroundingTiles = game_map.getNeighbours(item)
		for neighbour in surroundingTiles:
			var type: GameMap2D.GameTileData = game_map.getTileData(neighbour)
			if type[neighbour_property]:
				adjacent_to_claimed_tile = true
				break;
		
		if !adjacent_to_claimed_tile:
			continue;
			
		var current_manhatten_distance = abs(item.x - agent.global_position.x) + abs(item.y - agent.global_position.y)
		
		if  current_manhatten_distance > distanceToTarget: # Pick the closer one
			continue
					
		target = item
		distanceToTarget = current_manhatten_distance
	
	if target != null:
		target_found.emit(target)
	else:
		no_target_found.emit()
		

