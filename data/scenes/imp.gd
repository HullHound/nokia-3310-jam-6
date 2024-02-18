extends Node2D

signal died;

@export var tilemap: TileMap
@export var fog_of_war: TileMap
@export var team_id: int

@onready var fsm: FiniteStateMachine = $FiniteStateMachine


@onready var search_for_mine_target: Node = $FiniteStateMachine/SearchForMineTarget

@onready var search_for_claim_target: Node = $FiniteStateMachine/SearchForClaimTarget
@onready var move_to_claim_target: Node = $FiniteStateMachine/MoveToClaimTarget
@onready var move_to_mine_target: MoveToLocationState = $FiniteStateMachine/MoveToMineTarget

@onready var attack: Node = $FiniteStateMachine/Attack
@onready var move_nearby: Node = $FiniteStateMachine/MoveNearby
@onready var claim: Node = $FiniteStateMachine/Claim
@onready var mine: Node = $FiniteStateMachine/Mine

@onready var health: Health = $Health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NavigationAgent2D.set_navigation_map(tilemap.get_layer_navigation_map(0))
	
	$DamageTarget2D.team_id = team_id
	$FogOfWarRemover.fog_of_war = fog_of_war
	search_for_claim_target.fog_of_war = fog_of_war
	search_for_claim_target.tilemap = tilemap
	search_for_mine_target.tilemap = tilemap
	claim.tilemap = tilemap
	
	search_for_mine_target.target_found.connect(func(target): move_to_mine_target.set_target(target); fsm.change_state(move_to_mine_target))
	search_for_mine_target.no_target_found.connect(fsm.change_state.bind(search_for_claim_target))
	
	move_to_mine_target.target_reached.connect(fsm.change_state.bind(mine))
	move_to_mine_target.target_unreachable.connect(fsm.change_state.bind(search_for_mine_target))
	
	search_for_claim_target.target_found.connect(func(target): move_to_claim_target.set_target(target); fsm.change_state(move_to_claim_target))
	search_for_claim_target.no_target_found.connect(fsm.change_state.bind(move_nearby))
	
	move_to_claim_target.target_reached.connect(fsm.change_state.bind(claim))	
	move_to_claim_target.target_unreachable.connect(fsm.change_state.bind(search_for_claim_target))
	
	move_nearby.target_reached.connect(fsm.change_state.bind(search_for_claim_target))
	move_nearby.target_unreachable.connect(fsm.change_state.bind(search_for_claim_target))

	claim.finished.connect(fsm.change_state.bind(search_for_claim_target))

	$FogOfWarRemover.remove_fog_of_war()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func die():
	died.emit()
	queue_free()

func _on_damage_target_2d_damaged(damage_amount: float) -> void:
	$AnimationPlayer.play("damaged")
	health.decrement_health(damage_amount)
	
