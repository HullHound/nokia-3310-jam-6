extends State

@export var agent: Node2D
@export var game_map: GameMap2D

signal target_found(target: Vector2)
signal no_target_found

var enabled = false
var search_property = "toBeMined"

func _enter_state() -> void:
	enabled = true

func _exit_state() -> void:
	enabled = false



func _physics_process(_delta: float) -> void:
	if !enabled:
		return
	
	pick_claim_target()
	
func pick_claim_target():
	var potentialTargets: Array[Vector2] = game_map.getMineTargets()
	potentialTargets.shuffle()
	
	var target = null
	for item in potentialTargets:
		# Check can be reached
		if !canReach(item):
			continue
			
		# TODO - Distance Check - prioritise closer? / Closer to Dungeon Heart?
		
		target = item
		
	if target != null:
		target_found.emit(target)
	elif target == null:
		no_target_found.emit()
		
func canReach(location:Vector2):
	var neighbours = game_map.getNeighbours(location)
	
	for cell in neighbours:
		var newPath = game_map.getPath(agent.global_position, cell);
		
		if newPath.size() > 1:
			return true
			
	return false;
		

