extends Node

@export var random_quips: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GoldTreasury.not_enough_gold.connect(not_enough_gold)
	MessageSystem.no_message_gap.connect(no_message_gap)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func not_enough_gold():
	MessageSystem.displayMessage("You don't have enough gold")

func no_message_gap():
	MessageSystem.displayMessage(random_quips.pick_random())
