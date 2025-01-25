extends Control

const WORLD = preload("res://game/world/world.tscn")


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_packed(WORLD)



func _on_exit_game_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://game/ui/credits_menu.tscn")
