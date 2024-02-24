extends State

@export var selection_point: Node2D
@export var game_map: GameMap2D

@export var MineRayCast: RayCast2D
@export var MineableMark: PackedScene
@export var mark_container: Node2D

const BLIP_9 = preload("res://data/sounds/blip9.wav")
const BLIP_14 = preload("res://data/sounds/blip14.wav")

var enabled = false

signal finished

func _enter_state() -> void:
	enabled = true
	markAsMineable()

func _exit_state() -> void:
	enabled = false
	
func _physics_process(_delta: float) -> void:
	if !enabled:
		return

	finished.emit()
	
func markAsMineable() -> void:	
	var tile = selection_point.global_position
	
	if !game_map.isVisible(tile):
		return
		
	if MineRayCast.is_colliding():
		# Remove Mark
		var mark = MineRayCast.get_collider() as Area2D
		game_map.clearMineTarget(mark)
		mark.queue_free()
		AudioManager.play_sfx(BLIP_14)
		return
	
	var tileData = game_map.getTileData(tile)
	
	if tileData.couldBeMined: 
		#instantiate Mark
		var mark = MineableMark.instantiate() as Area2D
		game_map.registerMineTarget(mark)
		mark.top_level = true
		mark_container.add_child(mark)
		mark.global_position = tile - Vector2(4,4)
		AudioManager.play_sfx(BLIP_9)
