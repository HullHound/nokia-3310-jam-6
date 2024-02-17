extends Node2D

signal died;

@export var tilemap: TileMap
@export var fog_of_war: TileMap

@onready var fsm: FiniteStateMachine = $FiniteStateMachine

@onready var search_for_target: Node = $FiniteStateMachine/SearchForTarget
@onready var move_to_location: Node = $FiniteStateMachine/MoveToLocation


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NavigationAgent2D.set_navigation_map(tilemap.get_layer_navigation_map(0))
	$FogOfWarRemover.fog_of_war = fog_of_war
	
	search_for_target.target_found.connect(func(target): move_to_location.set_target(target.global_position); fsm.change_state(move_to_location))
	#move_to_location.target_reached.connect(fsm.)
	move_to_location.target_unreachable.connect(fsm.change_state.bind(search_for_target))

	$FogOfWarRemover.remove_fog_of_war()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_down"):
		$FiniteStateMachine/MoveToLocation.set_target(Vector2(8*6,0))

func die():
	died.emit()

func _on_damage_target_2d_damaged(damage_amount: float) -> void:
	$AnimationPlayer.play("damaged")
