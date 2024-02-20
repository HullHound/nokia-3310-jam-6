extends State

@export var build_place_holder: BuildPlaceholder
@export var BuildingPreFab: PackedScene
@export var build_container: Node2D

var enabled = false

signal finished

func _enter_state() -> void:
	enabled = true
	buildBuilding()

func _exit_state() -> void:
	enabled = false	

func _input(event: InputEvent) -> void:
	if !enabled:
		return

	finished.emit()
	
func buildBuilding():
	var node = BuildingPreFab.instantiate() as Node2D
	node.global_position = build_place_holder.global_position
	build_container.add_child(node)
	#TODO = Particle Effet / Sound / Animation
