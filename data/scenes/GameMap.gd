@tool
extends Node
class_name GameMap2D

@export var region: Rect2i = Rect2i(0,0, 84*2, 48 * 2)
@export var cell_size: Vector2 = Vector2(8,8)
@export var diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
@export var jumping_enabled:bool = true
@export var heuristic = AStarGrid2D.HEURISTIC_MANHATTAN 
@export var offset = Vector2(4,-4)

@export var tile_map_layer = 3
@export var ground_atlas_coords: Vector2i
@export var claimedPlayer_atlas_coords: Vector2i
@export var claimedEnemy_atlas_coords: Vector2i

var WalkableCustomParam = "Walkable"

var astar_grid: AStarGrid2D = AStarGrid2D.new()

var tileMap: TileMap
var fog_of_war: TileMap

class GameTileData:
	var containsGold: bool
	var isWalkable: bool
	var couldBeMined: bool
	var toBeMined: bool
	var couldBeClaimed_Player: bool
	var couldBeClaimed_Enemy: bool
	var claimedPlayer: bool
	var claimedEnemy: bool

enum TileType {
	Ground,
	ClaimedPlayer,
	ClaimedEnemy
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	astar_grid.cell_size = cell_size
	astar_grid.region = region
	astar_grid.diagonal_mode = diagonal_mode
	astar_grid.jumping_enabled = jumping_enabled
	astar_grid.default_compute_heuristic = heuristic
	astar_grid.default_estimate_heuristic = heuristic
	astar_grid.offset = offset
	astar_grid.update()
	
	tileMap = $Map
	fog_of_war = $FogOfWar
	
	_populateTileObstacles()

func _get_configuration_warnings() -> PackedStringArray:
	if !$Map:
		return PackedStringArray(["A tilemap called 'Map' is required as a child"])

	if !$FogOfWar:
		return PackedStringArray(["A tilemap called 'FogOfWar' is required as a child"])

	return PackedStringArray([])
	
func _populateTileObstacles():
	var filledCells = tileMap.get_used_cells(0)
	
	for cell in filledCells:
		var tileData = tileMap.get_cell_tile_data(0, cell)
		astar_grid.set_point_solid(cell, !tileData.get_custom_data("Walkable"))

func getPath(start: Vector2, destination: Vector2):
	if astar_grid.is_dirty():
		astar_grid.update()
	
	var startLocation = tileMap.local_to_map(start)
	var endLocation = tileMap.local_to_map(destination)
	
	var output: PackedVector2Array = PackedVector2Array([])
	
	if !astar_grid.is_in_boundsv(startLocation) || !astar_grid.is_in_boundsv(endLocation):
		return output
	
	for item in astar_grid.get_point_path(startLocation, endLocation):
		output.append(tileMap.map_to_local(item))

	return output
	
#func getDistance(start: Vector2, destination: Vector2):
	#return getPath(start, destination).size()
	
#func getNextPathPoint(start: Vector2, destination: Vector2):
	#var path = getPath(start, destination)
	#if path.size() > 0:
		#return path[0]
	#else:
		#return null

func getTileData(tile:Vector2):
	var position = tileMap.local_to_map(tile)
	var tileData = tileMap.get_cell_tile_data(0, position)

	if tileData == null:
		return GameTileData.new() # or null?
	
	var gameData = GameTileData.new()
	gameData.containsGold = tileData.get_custom_data("Gold")
	gameData.isWalkable = tileData.get_custom_data(WalkableCustomParam)
	gameData.couldBeMined = tileData.get_custom_data("couldBeMined")
	gameData.toBeMined = tileData.get_custom_data("toBeMined")
	gameData.couldBeClaimed_Player = tileData.get_custom_data("couldBeClaimed_Player")
	gameData.couldBeClaimed_Enemy = tileData.get_custom_data("couldBeClaimed_Enemy")
	gameData.claimedPlayer = tileData.get_custom_data("claimedPlayer")	
	gameData.claimedEnemy = tileData.get_custom_data("claimedEnemy")
	
	return gameData
	
func clearTile(tile: Vector2):
	var location = tileMap.local_to_map(tile)
	tileMap.set_cell(0, location, tile_map_layer, ground_atlas_coords)
	astar_grid.set_point_solid(location, false)
		
func setTile(tile: Vector2, tileType: TileType):
	var location = tileMap.local_to_map(tile)
	
	match tileType:
		TileType.ClaimedPlayer:
			tileMap.set_cell(0, location, tile_map_layer, claimedPlayer_atlas_coords)
			astar_grid.set_point_solid(location, false)
		TileType.ClaimedEnemy:
			tileMap.set_cell(0, location, tile_map_layer, claimedEnemy_atlas_coords)
			astar_grid.set_point_solid(location, false)
		_:
			pass	
	

func getTilesWithProperty(property: String):
	var output: PackedVector2Array = PackedVector2Array([])
	
	for tile in tileMap.get_used_cells(0):		
		var tileData = tileMap.get_cell_tile_data(0, tile)
		if tileData.get_custom_data(property):
			output.append(tileMap.map_to_local(tile))

	return output

func _convertToOutputCoords(coords: Array[Vector2i]):
	var output: Array[Vector2] = []
	
	for item in coords:
		output.append(tileMap.map_to_local(item))
		
	return output;
	
func getNeighbours(tile: Vector2):
	return _convertToOutputCoords(tileMap.get_surrounding_cells(tileMap.local_to_map(tile)))

func isVisible(tile:Vector2):
	return fog_of_war.get_cell_source_id(0, fog_of_war.local_to_map(tile)) == -1

func markVisible(tile:Vector2):
	var location = fog_of_war.local_to_map(tile)
	fog_of_war.erase_cell(0, location)
	
func areLocationsTheSame(first: Vector2, second: Vector2):
	return tileMap.local_to_map(first) == tileMap.local_to_map(second)
