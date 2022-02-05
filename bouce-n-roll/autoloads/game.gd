extends Node

const game_scene_path : String = "res://game/game.tscn"
const menu_scene_path : String = "res://menu/menu.tscn"

var level : int = 0

func _ready():
	randomize()
	
func load_game_scene() -> void:
	var err : int = get_tree().change_scene(game_scene_path)
	if err != 0:
		print('[reload_scene] Something went wrong, error code: ', err)
	
func load_menu_scene() -> void:
	var err : int = get_tree().change_scene(menu_scene_path)
	if err != 0:
		print('[reload_scene] Something went wrong, error code: ', err)
