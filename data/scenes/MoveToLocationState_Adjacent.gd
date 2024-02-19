extends MoveToLocationState
class_name MoveToLocationState_Adjacent

func isAtEndOfPath():
	var position = agent.global_position
	return game_map.getDistance(position, destination) <= 1
	
func getPathToDestination():
	# Calculate the Closest Adjacent Cell to get to
	var position = agent.global_position
	var neighbours = game_map.getNeighbours(destination)
	
	var path = null
	
	for cell in neighbours:
		var newPath = game_map.getPath(position, cell);
		
		if path == null || path.size > newPath.size:
			path = newPath
	
	# Not sure if arrays have reference equality
	if path == null:
		return []
	else:
		return path
