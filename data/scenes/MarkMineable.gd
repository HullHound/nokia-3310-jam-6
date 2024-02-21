extends State

@export var selection_point: Node2D
@export var game_map: GameMap2D

var enabled = false

signal finished

func _enter_state() -> void:
	enabled = true
	markAsMineable()

func _exit_state() -> void:
	enabled = false
	
func _physics_process(delta: float) -> void:
	if !enabled:
		return

	finished.emit()
	
func markAsMineable() -> void:	
	var tile = selection_point.global_position
	
	if !game_map.isVisible(tile):
		return
	
	var tileData = game_map.getTileData(tile)
	
	if !tileData.couldBeMined && !tileData.toBeMined: 
		return;

	if tileData.couldBeMined:
		if tileData.containsGold:
			game_map.setTile(tile, GameMap2D.TileType.SelectedGoldWall)
		else:
			game_map.setTile(tile, GameMap2D.TileType.SelectedWall)
	elif tileData.toBeMined:
		if tileData.containsGold:			
			game_map.setTile(tile, GameMap2D.TileType.GoldWall)
		else:
			game_map.setTile(tile, GameMap2D.TileType.Wall)


