extends Node2D

@export var fog_of_war: TileMap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func remove_fog_of_war():
	var current_tile = fog_of_war.local_to_map(global_position)
	var surroundingCells = fog_of_war.get_surrounding_cells(current_tile)
	
	for x in range(current_tile.x -1, current_tile.x + 2, 1):
		for y in range(current_tile.y -1, current_tile.y + 2, 1):
			var coords: Vector2i = Vector2i(x,y)
			fog_of_war.set_cell(0, coords);
