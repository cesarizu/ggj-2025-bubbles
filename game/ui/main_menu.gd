extends Control

const WORLD = preload("res://game/world/world.tscn")


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_packed(WORLD)
