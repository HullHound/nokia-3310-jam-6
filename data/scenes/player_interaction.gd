extends Node2D

@onready var build_placeholder: BuildPlaceholder = $BuildPlaceholder


@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var wait_for_input: Node = $FiniteStateMachine/WaitForInput
@onready var mark_mineable: Node = $FiniteStateMachine/MarkMineable
@onready var place_building: Node = $FiniteStateMachine/PlaceBuilding
@onready var build_building: Node = $FiniteStateMachine/BuildBuilding
@onready var slap: Node = $FiniteStateMachine/Slap


@export var game_map: GameMap2D
@export var build_container: Node2D
@export var team_id: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_placeholder.game_map = game_map
	mark_mineable.game_map = game_map
	build_building.build_container = build_container
	
	wait_for_input.minePressed.connect(fsm.change_state.bind(mark_mineable))	
	wait_for_input.buildPressed.connect(fsm.change_state.bind(place_building))
	wait_for_input.slapPressed.connect(fsm.change_state.bind(slap))
	
	mark_mineable.finished.connect(fsm.change_state.bind(wait_for_input))
	
	place_building.build.connect(fsm.change_state.bind(build_building))
	place_building.canceled.connect(fsm.change_state.bind(wait_for_input))
	
	build_building.finished.connect(fsm.change_state.bind(wait_for_input))
	slap.finished.connect(fsm.change_state.bind(wait_for_input))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_build_building_build_callback(node: Node2D) -> void:
	var lair = node as Lair
	lair.game_map = game_map
	lair.spawn_container = build_container
	lair.team_id = team_id
