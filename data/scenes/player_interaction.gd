extends Node2D

@onready var build_placeholder: BuildPlaceholder = $BuildPlaceholder


@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var wait_for_input: Node = $FiniteStateMachine/WaitForInput
@onready var mark_mineable: Node = $FiniteStateMachine/MarkMineable
@onready var place_building: Node = $FiniteStateMachine/PlaceBuilding

@export var game_map: GameMap2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_placeholder.game_map = game_map
	mark_mineable.game_map = game_map
	
	wait_for_input.minePressed.connect(fsm.change_state.bind(mark_mineable))	
	wait_for_input.buildPressed.connect(fsm.change_state.bind(place_building))
	
	mark_mineable.finished.connect(fsm.change_state.bind(wait_for_input))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
