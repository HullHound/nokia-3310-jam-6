extends MoveToLocationState

func _enter_state() -> void:
	super()
	set_destination()

func set_destination():
	var goalX = 0
	var goalY = 0
	
	var tile_size = game_map.cell_size
	
	while goalX == 0 && goalY == 0:
		goalX = randi_range(-1, 1) * tile_size.x
		goalY = randi_range(-1, 1) * tile_size.y
	
	var destination = agent.global_position + Vector2(goalX, goalY)
	
	set_target(destination)
