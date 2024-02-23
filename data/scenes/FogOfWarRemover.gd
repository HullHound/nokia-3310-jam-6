extends Node2D

@export var game_map: GameMap2D
@export var tile_size = 8
@export var enabled = true	

func remove_fog_of_war():
	if !enabled:
		return
	
	var current_tile = global_position
	
	for x in range(current_tile.x - 2 * tile_size, current_tile.x + 3 * tile_size, tile_size):
		for y in range(current_tile.y - 2 * tile_size, current_tile.y + 3 * tile_size, tile_size):
			var manhatten_distance = abs(current_tile.x - x) + abs(current_tile.y - y)
			
			if manhatten_distance <= tile_size * 2:
				var coords: Vector2 = Vector2(x,y)
				game_map.markVisible(coords)
