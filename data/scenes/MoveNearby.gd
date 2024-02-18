extends MoveToLocationState


func _enter_state() -> void:
	super()
	set_destination()

func set_destination():
	var goalX = 0
	var goalY = 0
	
	while goalX == 0 && goalY == 0:
		goalX = randi_range(-1, 1) * tile_size
		goalY = randi_range(-1, 1) * tile_size
	
	var destination = agent.global_position + Vector2(goalX, goalY)
	print(destination)
	set_target(destination)
