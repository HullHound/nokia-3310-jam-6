extends MoveToLocationState
class_name MoveToLocationState_Adjacent

func isAtEndOfPath():
	return getPathToDestination().size() <= 1;
	
func getPathToDestination():
	# Calculate the Closest Adjacent Cell to get to
	var position = agent.global_position
	var neighbours = game_map.getNeighbours(destination)
	
	var path = null
	
	for cell in neighbours:
		var newPath = game_map.getPath(position, cell);
		if newPath.size() == 0:
			continue;
		
		if path == null || path.size() > newPath.size():
			path = newPath
	
	# Not sure if arrays have reference equality
	if path == null:
		return []
	else:
		return path
