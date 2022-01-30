extends Node


var menu_scene_path : String = "res://menu-ui/menu-ui.tscn"
var game_scene_path : String = "res://game/game.tscn"

func scene_game() -> void:
	var err : int = get_tree().change_scene(game_scene_path)
	if err != 0:
		print('[reload_scene] Something went wrong, error code: ', err)
		
func scene_menu() -> void:
	var err : int = get_tree().change_scene(menu_scene_path)
	if err != 0:
		print('[reload_scene] Something went wrong, error code: ', err)
