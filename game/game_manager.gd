extends Node

const WORLD = preload("res://game/world/world.tscn")

var level := 1


func new_game() -> void:
	get_tree().change_scene_to_packed(WORLD)
	level = 1


func game_over() -> void:
	pass
