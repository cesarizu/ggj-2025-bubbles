extends Node

const WORLD = preload("res://game/world/world.tscn")
const MAIN_MENU = preload("res://game/ui/main_menu.tscn")
const INSTRUCTIONS_MENU = preload("res://game/ui/instructions_menu.tscn")
const CREDITS_MENU = preload("res://game/ui/credits_menu.tscn")
const GAME_OVER_MENU = preload("res://game/ui/game_over_menu.tscn")

var level := 1


func new_game() -> void:
	get_tree().change_scene_to_packed(WORLD)
	level = 1


func game_over() -> void:
	pass


func main_menu() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)

func instructions_menu() -> void:
	get_tree().change_scene_to_packed(INSTRUCTIONS_MENU)

func credits_menu() -> void:
	get_tree().change_scene_to_packed(CREDITS_MENU)

func game_over_menu() -> void:
	get_tree().change_scene_to_packed(GAME_OVER_MENU)
