extends Node
class_name Spawner2D

@export var spawn_location: Marker2D
@export var spawn_prefab: PackedScene
@export var spawn_container: Node2D

@export var max_number_of_spawns = 2
@export var spawns: Array[Node2D]
@export var min_time_to_spawn: float = 4.0
@export var max_time_to_spawn: float = 10.0

signal spawn_callback(node: Node2D)

var spawn_lock = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_restart_spawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_spawn():
	if spawn_lock:
		return	
	
	spawn_lock = true
	
	var time_to_spawn = randf_range(min_time_to_spawn, max_time_to_spawn)
	
	await get_tree().create_timer(time_to_spawn).timeout
	
	var node = spawn_prefab.instantiate() as Node2D
	node.global_position = spawn_location.global_position
	spawns.append(node)
	
	spawn_callback.emit(node)
	
	spawn_container.add_child(node)
	
	spawn_lock = false
	
	_restart_spawn()

func remove_spawn(spawn: Node2D):
	spawns.erase(spawn)
	_restart_spawn()
	
func _restart_spawn():
	if spawns.size() < max_number_of_spawns:
		start_spawn()
