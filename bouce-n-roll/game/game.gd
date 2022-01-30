extends Spatial

export (int, 5, 30) var game_time : int = 20

onready var game_ui : Control = $GameUI
onready var timer : Timer = $SecondTimer
onready var platform : RigidBody = $Platform
onready var current_time : int = game_time

func _ready():
	GameGlobal.player_score = 0
	game_ui.set_score(GameGlobal.player_score)
	timer.start()
	game_ui.set_time(current_time)

func _on_SecondTimer_timeout():
	current_time -= 1
	game_ui.set_time(current_time)
	if current_time <= 0:
		SceneManager.scene_menu()


func _on_Item_hit(by):
	if randf() < 0.5:
		platform.rotate_negative()
	else:
		platform.rotate_positive()
	if "player" in by:
		GameGlobal.update_score()
		game_ui.set_score(GameGlobal.player_score)
	elif "npc" in by:
		pass
