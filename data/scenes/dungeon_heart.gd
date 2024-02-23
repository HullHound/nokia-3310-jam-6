extends Node2D

signal died;



@export var team_id: int :
	set(value):
		$DamageTarget2D.team_id = value
	get:
		return $DamageTarget2D.team_id

@export var game_map: GameMap2D

@export_group("Imp Details")
@export var spawns: Array[Node2D]
@export var spawn_container: Node2D
@export var max_number_of_spawns = 0

@export var claim_search_property: String = "couldBeClaimed_Player"
@export var claim_neighbour_property: String = "claimedPlayer"
@export var claim_type: GameMap2D.TileType = GameMap2D.TileType.ClaimedPlayer

@onready var spawner: Spawner2D = $Spawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawner.max_number_of_spawns = max_number_of_spawns
	spawner.spawns = spawns
	spawner.spawn_container = spawn_container
	
	if $DamageTarget2D.team_id == 0:
		$FogOfWarRemover.game_map = game_map
		$FogOfWarRemover.remove_fog_of_war()
		
	game_map.setSolid(global_position)	
	
	spawner.start_spawn()

func die():
	died.emit()

func _on_damage_target_2d_damaged(_damage_amount: float) -> void:
	$AnimationPlayer.play("damaged")
	$AnimationPlayer.queue("heart_beat")


func _on_spawner_spawn_callback(node: Node2D) -> void:
	
	var imp = node as Imp;
	imp.game_map = game_map
	imp.team_id = team_id
	imp.claim_neighbour_property = claim_neighbour_property
	imp.claim_search_property = claim_search_property
	imp.claim_type = claim_type
	
	imp.died.connect($Spawner.remove_spawn.bind(node))
