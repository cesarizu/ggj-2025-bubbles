extends Node

const WORLD = preload("res://game/world/world.tscn")
const MAIN_MENU = preload("res://game/ui/main_menu.tscn")
const INSTRUCTIONS_MENU = preload("res://game/ui/instructions_menu.tscn")
const CREDITS_MENU = preload("res://game/ui/credits_menu.tscn")
const GAME_OVER_MENU = preload("res://game/ui/game_over_menu.tscn")
const PAUSE = preload("res://game/ui/pause.tscn")
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


func pause(paused: bool) -> void:
	get_tree().paused = paused

	if paused:
		var pause := PAUSE.instantiate()
		add_child(pause)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"pause"):
		pause(true)

	if event.is_action_pressed(&"fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
