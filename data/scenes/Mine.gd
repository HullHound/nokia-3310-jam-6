extends State

@export var target_tile: Vector2
@export var game_map: GameMap2D
@export var tilemap_source_id = 3
@export var ground_source_id: Vector2i
@export var overlay_player: AnimationPlayer

@export var time_to_mine: float = 3.0

var enabled = false
var current_mine_time = 0.0

signal gold_mined
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
		var tileData = game_map.getTileData(target_tile)
		game_map.clearTile(target_tile)
		
		if tileData.containsGold:
			gold_mined.emit()
		
		finished.emit()
