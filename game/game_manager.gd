extends Node

const MAIN_MENU = preload("res://game/ui/main_menu.tscn")
const CREDITS_MENU = preload("res://game/ui/credits_menu.tscn")
const INSTRUCTIONS_MENU = preload("res://game/ui/instructions_menu.tscn")
const WORLD = preload("res://game/world/world.tscn")
const PAUSE = preload("res://game/ui/pause.tscn")
const GAME_OVER_MENU = preload("res://game/ui/game_over_menu.tscn")

var playing := false
var level := 1


func new_game() -> void:
	get_tree().change_scene_to_packed(INSTRUCTIONS_MENU)


func start_game() -> void:
	get_tree().change_scene_to_packed(WORLD)
	playing = true
	level = 1


func game_over() -> void:
	playing = false
	pass


func main_menu() -> void:
	playing = false
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
		add_child(PAUSE.instantiate())


func quit() -> void:
	get_tree().quit()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"pause"):
		if playing:
			pause(true)
		else:
			quit()

	if event.is_action_pressed(&"fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
