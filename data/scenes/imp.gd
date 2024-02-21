extends Node2D
class_name Imp

signal died;

@export var game_map: GameMap2D
@export var team_id: int

@export var claim_search_property = "couldBeClaimed_Player"
@export var claim_neighbour_property = "claimedPlayer"
@export var claim_type: GameMap2D.TileType = GameMap2D.TileType.ClaimedPlayer

@onready var fsm: FiniteStateMachine = $FiniteStateMachine


@onready var search_for_mine_target: Node = $FiniteStateMachine/SearchForMineTarget

@onready var search_for_claim_target: Node = $FiniteStateMachine/SearchForClaimTarget
@onready var move_to_claim_target: Node = $FiniteStateMachine/MoveToClaimTarget
@onready var move_to_mine_target: MoveToLocationState = $FiniteStateMachine/MoveToMineTarget

@onready var move_nearby: Node = $FiniteStateMachine/MoveNearby
@onready var claim: Node = $FiniteStateMachine/Claim
@onready var mine: Node = $FiniteStateMachine/Mine

@onready var health: Health = $Health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DamageTarget2D.team_id = team_id
	$FogOfWarRemover.game_map = game_map
	search_for_claim_target.game_map = game_map
	search_for_mine_target.game_map = game_map
	claim.game_map = game_map
	mine.game_map = game_map
	move_nearby.game_map = game_map
	move_to_claim_target.game_map = game_map
	move_to_mine_target.game_map = game_map
	
	search_for_claim_target.search_property = claim_search_property	
	search_for_claim_target.neighbour_property = claim_neighbour_property
	claim.claim_type = claim_type
	
	search_for_mine_target.target_found.connect(func(target): move_to_mine_target.set_target(target); mine.target_tile = target; fsm.change_state(move_to_mine_target))
	search_for_mine_target.no_target_found.connect(fsm.change_state.bind(search_for_claim_target))
	
	move_to_mine_target.target_reached.connect(fsm.change_state.bind(mine))
	move_to_mine_target.target_unreachable.connect(fsm.change_state.bind(move_nearby))
	
	search_for_claim_target.target_found.connect(func(target): move_to_claim_target.set_target(target); fsm.change_state(move_to_claim_target))
	search_for_claim_target.no_target_found.connect(fsm.change_state.bind(move_nearby))
	
	move_to_claim_target.target_reached.connect(fsm.change_state.bind(claim))	
	move_to_claim_target.target_unreachable.connect(fsm.change_state.bind(move_nearby))
	
	move_nearby.target_reached.connect(fsm.change_state.bind(search_for_mine_target))
	move_nearby.target_unreachable.connect(fsm.change_state.bind(search_for_mine_target))

	claim.finished.connect(fsm.change_state.bind(search_for_mine_target))
	mine.finished.connect(fsm.change_state.bind(search_for_mine_target))

	$FogOfWarRemover.remove_fog_of_war()	
	game_map.setSolid(global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func die():
	died.emit()
	queue_free()

func _on_damage_target_2d_damaged(damage_amount: float) -> void:
	$AnimationPlayer.play("damaged")
	health.decrement_health(damage_amount)
	


func _on_mine_gold_mined() -> void:
	print("gold Mined")
