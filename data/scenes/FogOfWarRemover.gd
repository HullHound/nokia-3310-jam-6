extends Node2D

@export var game_map: GameMap2D
@export var tile_size = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func remove_fog_of_war():
	var current_tile = global_position
	
	for x in range(current_tile.x -tile_size, current_tile.x + 2 * tile_size, tile_size):
		for y in range(current_tile.y - tile_size, current_tile.y + 2 * tile_size, tile_size):
			var coords: Vector2 = Vector2(x,y)
			game_map.markVisible(coords)
