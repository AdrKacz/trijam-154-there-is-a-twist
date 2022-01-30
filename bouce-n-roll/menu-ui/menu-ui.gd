extends Control

func _ready():
	$VBoxContainer/LastScoreLabel.text = "Last score: %02d" % GameGlobal.player_score
	$VBoxContainer/BestScoreLabel.text = "Best score: %02d" % GameGlobal.best_player_score

func _on_StartButton_pressed():
	SceneManager.scene_game()
