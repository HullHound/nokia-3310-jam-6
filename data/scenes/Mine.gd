extends State

@export var target_tile: Vector2
@export var tilemap: TileMap
@export var tilemap_source_id = 3
@export var ground_source_id: Vector2i
@export var overlay_player: AnimationPlayer

@export var time_to_mine: float = 3.0

var enabled = false
var current_mine_time = 0.0

signal finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _enter_state() -> void:
	enabled = true	
	current_mine_time = 0.0
	#overlay_player.play("mine")

func _exit_state() -> void:
	enabled = false
		
func _physics_process(delta: float) -> void:
	if !enabled:
		return
		
	current_mine_time += delta
	
	if current_mine_time >= time_to_mine:
		var position = tilemap.local_to_map(target_tile)
		tilemap.set_cell(0, position, tilemap_source_id, ground_source_id)
		finished.emit()
