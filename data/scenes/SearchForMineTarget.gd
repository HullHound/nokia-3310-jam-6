extends State

@export var tilemap: TileMap
@export var mineable_source_ids: Array[Vector2i]

signal target_found(target: Vector2)
signal no_target_found

var enabled = false

func _enter_state() -> void:
	enabled = true

func _exit_state() -> void:
	enabled = false



func _physics_process(delta: float) -> void:
	if !enabled:
		return
	
	pick_claim_target()
	
func pick_claim_target():
	var potentialTargets: Array[Vector2i] = []
	
	for type in mineable_source_ids:			
		potentialTargets.append_array(tilemap.get_used_cells_by_id(0, -1, type))
	
	var target = null
	for item in potentialTargets:	
		
		# Check Connected to a currently walkable Tile
		var adjacent_to_walkable_tile = false
		var surroundingTiles = tilemap.get_surrounding_cells(item)
		for neighbour in surroundingTiles:
			var type = tilemap.get_cell_tile_data(0, neighbour)
			if type.get_custom_data('Walkable') == true:
				adjacent_to_walkable_tile = true
				break;
		
		if !adjacent_to_walkable_tile:
			continue;
			
		# TODO - Distance Check - prioritise closer? / Closer to Dungeon Heart?
		
		
		target = item
		
	if target != null:
		target_found.emit(tilemap.map_to_local(target))
	elif target == null:
		no_target_found.emit()
		

