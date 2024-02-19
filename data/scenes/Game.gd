extends Node

var music:AudioStream = preload("res://data/music/tune.wav")

func _ready() -> void:
	AudioManager.play_music(music)

func _input(event: InputEvent) -> void:
	pass
	
func _on_player_dungeon_heart_died() -> void:
	print('player died')

func _on_enemy_dungeon_heart_died() -> void:
	$UI/EndScreen.showScreen("You have conquered this realm!", "Play again?")

func _on_end_screen_restart_requested() -> void:
	get_tree().reload_current_scene()
