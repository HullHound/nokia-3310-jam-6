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



func _physics_process(delta: float) -> void:
	if !enabled:
		return
	
	pick_claim_target()
	
func pick_claim_target():
	var potentialTargets: PackedVector2Array = game_map.getTilesWithProperty(search_property)
	
	var target = null
	for item in potentialTargets:
		# Check can be reached
		if game_map.getPath(agent.global_position, item).size() <= 1:
			continue
			
		# TODO - Distance Check - prioritise closer? / Closer to Dungeon Heart?
		
		target = item
		
	if target != null:
		print('mine target found')
		target_found.emit(target)
	elif target == null:
		no_target_found.emit()
		

