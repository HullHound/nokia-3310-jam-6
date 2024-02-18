extends State
class_name MoveToLocationState

@export var agent: Node2D
@export var navigation_agent: NavigationAgent2D
@export var movement_delay: float = 1
@export var tile_size:int = 8

var enabled = false
var time_since_last_movement = 0.0

signal moved

signal target_reached
signal target_unreachable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_target(location: Vector2):
	navigation_agent.target_position = location

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _enter_state() -> void:
	enabled = true
	time_since_last_movement = 0.0

func _exit_state() -> void:
	enabled = false

func _physics_process(delta):
	time_since_last_movement += delta;
	
	if !enabled:
		return
	
	if navigation_agent.is_navigation_finished():
		target_reached.emit()
		return 
		
	if !navigation_agent.is_target_reachable():
		target_unreachable.emit()
		return
		
	if time_since_last_movement < movement_delay:
		return
	
	time_since_last_movement = 0

	var next_path_position: Vector2 = Vector2i(navigation_agent.get_next_path_position()/ tile_size)*tile_size
	
	agent.global_position = next_path_position;
	
	moved.emit()
