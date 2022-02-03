extends AudioStreamPlayer3D

export (Array, AudioStream) var audio_streams : Array = []
export (bool) var play_once = false
export (float, 0.1, 1) var repeat_delta = 0.3

var time_left_last_repeat: float = 0
var is_playing : bool = false

func _process(delta):
	if not play_once:
		if time_left_last_repeat < 0:
			if is_playing:
				play_random()
				time_left_last_repeat = repeat_delta
		else:
			time_left_last_repeat -= delta
	else:
		if is_playing:
			play_random()
			is_playing = false
		
func play_random():
	if audio_streams.size() == 0:
		return
	stream = audio_streams[randi() % audio_streams.size()]
	play()
