extends Area2D
class_name DamageTarget2D

@export var team_id: int = 0

signal damaged(damage_amount:float)

func damage(damage_amount: float):
	damaged.emit(damage_amount)
