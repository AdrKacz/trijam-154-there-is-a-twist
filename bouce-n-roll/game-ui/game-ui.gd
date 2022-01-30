extends Control


onready var label_time : Label = $MarginContainer/CenterContainer/Label
onready var label_score : Label = $ScoresContainer/HBoxContainer/ScorePlayer

func set_time(time : int) -> void:
	label_time.text = "%02d" % time
	
func set_score(score : int) -> void:
	label_score.text = "%02d" % score
