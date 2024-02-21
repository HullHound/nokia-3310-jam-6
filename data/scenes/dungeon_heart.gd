extends Node2D

signal died;

@export var team_id: int :
	set(value):
		$DamageTarget2D.team_id = value

@export var game_map: GameMap2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if $DamageTarget2D.team_id == 0:
		$FogOfWarRemover.game_map = game_map
		$FogOfWarRemover.remove_fog_of_war()
		
	game_map.setSolid(global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func die():
	died.emit()

func _on_damage_target_2d_damaged(damage_amount: float) -> void:
	$AnimationPlayer.play("damaged")
	$AnimationPlayer.queue("heart_beat")
