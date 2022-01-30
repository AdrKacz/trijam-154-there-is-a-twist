extends Node

var item_translation : Vector3 = Vector3()

var player_score : int = 0
var best_player_score : int = 0

func _ready():
	randomize()

func update_score():
	player_score += 1
	if player_score > best_player_score:
		best_player_score = player_score
