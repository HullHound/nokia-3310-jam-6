extends State
class_name MoveToLocationState

@export var agent: Node2D
@export var game_map: GameMap2D
@export var movement_delay: float = 1

var enabled = false
var time_since_last_movement = 0.0
var destination: Vector2

signal moved

signal target_reached
signal target_unreachable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_target(location: Vector2):
	destination = location

func _enter_state() -> void:
	enabled = true
	time_since_last_movement = 0.0

func _exit_state() -> void:
	enabled = false

func _physics_process(delta):
	time_since_last_movement += delta;
	
	if !enabled:
		return
		
	if isAtEndOfPath():
		target_reached.emit()
		return
	
	var path = getPathToDestination()
	
	if path.size() <= 1:
		target_unreachable.emit()
		return
	
	if time_since_last_movement < movement_delay:
		return
	
	time_since_last_movement = 0
	game_map.setSolid(agent.global_position, false)
	agent.global_position = path[1];	
	game_map.setSolid(agent.global_position, true)
	
	moved.emit()
	
func isAtEndOfPath():
	var position = agent.global_position
	return game_map.getPath(position, destination).size() == 1
	
func getPathToDestination():
	var position = agent.global_position
	return game_map.getPath(position, destination);
