extends State

@export var agent: Node2D
@export var tilemap: TileMap
@export var tilemap_source_id = 3
@export var claimed_source_id: Vector2i
@export var claim_overlay_player: AnimationPlayer

@export var time_to_claim: float = 3.0

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
	claim_overlay_player.play("claim")

func _exit_state() -> void:
	enabled = false
		
func _physics_process(delta: float) -> void:
	if !enabled:
		return
		
	current_claim_time += delta
	
	if current_claim_time >= time_to_claim:
		var position = tilemap.local_to_map(agent.global_position)
		tilemap.set_cell(0, position, tilemap_source_id, claimed_source_id)
		finished.emit()
