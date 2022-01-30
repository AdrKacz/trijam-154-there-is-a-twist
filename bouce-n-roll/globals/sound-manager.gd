extends Node

var is_mute : bool = true

onready var game_music : AudioStreamPlayer = $GameMusic

func play_game_music():
	if not is_mute:
		return
	is_mute = false
	game_music.play()
