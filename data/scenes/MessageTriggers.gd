extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GoldTreasury.not_enough_gold.connect(not_enough_gold)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func not_enough_gold():
	MessageSystem.displayMessage("You don't have enough gold")
