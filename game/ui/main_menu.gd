extends Control

func _on_new_game_pressed() -> void:
	GameManager.new_game()

func _on_credits_pressed() -> void:
	GameManager.credits_menu()

func _on_exit_game_pressed() -> void:
	get_tree().quit()
