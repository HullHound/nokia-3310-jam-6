extends Node2D

@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var wait_for_input: Node = $FiniteStateMachine/WaitForInput
@onready var mark_mineable: Node = $FiniteStateMachine/MarkMineable

@export var game_map: GameMap2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mark_mineable.game_map = game_map
	
	wait_for_input.minePressed.connect(fsm.change_state.bind(mark_mineable))
	mark_mineable.finished.connect(fsm.change_state.bind(wait_for_input))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
