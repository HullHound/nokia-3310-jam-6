extends MoveToLocationState

@export var tile_size = Vector2(8,8)

func _enter_state() -> void:
	super()
	set_destination()

func set_destination():
	var goalX = 0
	var goalY = 0
	
	while goalX == 0 && goalY == 0:
		goalX = randi_range(-1, 1) * tile_size.x
		goalY = randi_range(-1, 1) * tile_size.y
	
	var newDestination = agent.global_position + Vector2(goalX, goalY)
	
	set_target(newDestination)
