extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GoldTreasury.gold_value_changed.connect(updateGold)



func updateHealth(new_health: int):
	$HeartLabel.text = str(new_health)

func updateGold(new_gold: int):
	$GoldLabel.text = str(new_gold)
