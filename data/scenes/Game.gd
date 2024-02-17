extends Node

var music:AudioStream = preload("res://data/music/tune.wav")

func _ready() -> void:
	AudioManager.play_music(music)



func _on_player_dungeon_heart_died() -> void:
	print('died')
