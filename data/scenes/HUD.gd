extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GoldTreasury.gold_value_changed.connect(updateGold)
	GoldTreasury.not_enough_gold.connect(not_enough_gold)


func updateHealth(new_health: int):
	$HeartLabel.text = str(new_health)
	$HeartAnimationPlayer.play("HeartFlash")

func updateGold(new_gold: int):
	$GoldLabel.text = str(new_gold)

func not_enough_gold():
	$AnimationPlayer.play("Flash")
