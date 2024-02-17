extends Node2D

signal died;

@export var team_id: int :
	set(value):
		$DamageTarget2D.team_id = value

@export var fog_of_war: TileMap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if fog_of_war != null:
		$FogOfWarRemover.fog_of_war = fog_of_war
		$FogOfWarRemover.remove_fog_of_war()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func die():
	died.emit()

func _on_damage_target_2d_damaged(damage_amount: float) -> void:
	$AnimationPlayer.play("damaged")
	$AnimationPlayer.queue("heart_beat")
