extends State

@export var agent: Node2D
@export var game_map: GameMap2D
@export var overlay_player: AnimationPlayer

@export var time_to_claim: float = 3.0
@export var claim_type: GameMap2D.TileType = GameMap2D.TileType.ClaimedPlayer

var enabled = false
var current_claim_time = 0.0

signal finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _enter_state() -> void:
	enabled = true	
	current_claim_time = 0.0
	overlay_player.play("claim")

func _exit_state() -> void:
	enabled = false
		
func _physics_process(delta: float) -> void:
	if !enabled:
		return
		
	current_claim_time += delta
	
	if current_claim_time >= time_to_claim:
		game_map.setTile(agent.global_position, claim_type)
		finished.emit()
