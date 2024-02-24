extends State

@export var build_place_holder: BuildPlaceholder
@export var BuildingPreFab: PackedScene
@export var build_container: Node2D

const GOOD_3 = preload("res://data/sounds/good3.wav")

var enabled = false

signal finished
signal build_callback(node: Node2D)

func _enter_state() -> void:
	enabled = true
	buildBuilding()

func _exit_state() -> void:
	enabled = false	


func _physics_process(delta: float) -> void:
	if !enabled:
		return

	finished.emit()	

func buildBuilding():
	var node = BuildingPreFab.instantiate() as Node2D
	node.global_position = build_place_holder.global_position
	
	build_callback.emit(node)
	build_container.add_child(node)
	AudioManager.play_sfx(GOOD_3)

	#TODO = Particle Effet / Sound / Animation
