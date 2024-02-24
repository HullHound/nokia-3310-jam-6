extends Node2D
class_name Goblin

signal died;


@export var game_map: GameMap2D
@export var team_id: int
@export var image: Texture2D

@onready var fsm: FiniteStateMachine = $FiniteStateMachine

@onready var search_for_target: Node = $FiniteStateMachine/SearchForTarget
@onready var move_to_target: Node = $FiniteStateMachine/MoveToTarget
@onready var attack: Node = $FiniteStateMachine/Attack
@onready var move_nearby: Node = $FiniteStateMachine/MoveNearby

@onready var health: Health = $Health
const CRUST = preload("res://data/sounds/crust.wav")
const HIT_1 = preload("res://data/sounds/hit1.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DamageTarget2D.team_id = team_id
	search_for_target.team_id = team_id
	$FogOfWarRemover.game_map = game_map
	search_for_target.game_map = game_map
	move_nearby.game_map = game_map
	move_to_target.game_map = game_map
	$Sprite2D.texture = image
	
	search_for_target.target_found.connect(func(target): attack.set_target(target); move_to_target.target = target; fsm.change_state(move_to_target))
	search_for_target.no_target_found.connect(fsm.change_state.bind(move_nearby))
	
	move_to_target.target_reached.connect(fsm.change_state.bind(attack))	
	move_to_target.target_unreachable.connect(fsm.change_state.bind(move_nearby))
	
	attack.finished.connect(fsm.change_state.bind(search_for_target))
	
	move_nearby.target_reached.connect(fsm.change_state.bind(search_for_target))
	move_nearby.target_unreachable.connect(fsm.change_state.bind(search_for_target))

	$FogOfWarRemover.enabled = team_id == 0
	$FogOfWarRemover.remove_fog_of_war()
	game_map.setSolid(global_position)

func die():
	if team_id == 0:
		AudioManager.play_sfx(CRUST)
		MessageSystem.displayMessage("Your minions lost a battle")
	else:
		MessageSystem.displayMessage("Your creatures have won a battle")
	
	died.emit()
	queue_free()

func _on_damage_target_2d_damaged(damage_amount: float) -> void:
	$AnimationPlayer.play("damaged")
	if team_id == 0:
		AudioManager.play_sfx(HIT_1)
	health.decrement_health(damage_amount)
	


func _on_enemy_detector_area_entered(area: Area2D) -> void:
	if area is DamageTarget2D:
		var target = area as DamageTarget2D
		if target.team_id != team_id:
			attack.set_target(target);
			move_to_target.target = target;
			fsm.change_state(move_to_target)
	else:
		return
