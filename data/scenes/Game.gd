extends Node


const NEGATIVE_1 = preload("res://data/sounds/negative1.wav")
const JINGLE_1 = preload("res://data/sounds/jingle1.wav")

@onready var game_field: Node2D = $GameField

func _ready() -> void:
	pass #AudioManager.play_music(music)
	
func _on_player_dungeon_heart_died() -> void:
	game_field.process_mode = Node.PROCESS_MODE_DISABLED
	AudioManager.play_sfx(NEGATIVE_1)
	$PlayerInteraction/UI/EndScreen.showScreen("You have been defeated", "Try again?")

func _on_enemy_dungeon_heart_died() -> void:	
	game_field.process_mode = Node.PROCESS_MODE_DISABLED
	AudioManager.play_sfx(JINGLE_1)
	$PlayerInteraction/UI/EndScreen.showScreen("You have conquered this realm!", "Play again?")

func _on_end_screen_restart_requested() -> void:
	get_tree().reload_current_scene()
	
