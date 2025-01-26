extends Control

@onready var new_game: Button = %NewGame


func _ready() -> void:
	new_game.grab_focus.call_deferred()


func _on_new_game_pressed() -> void:
	GameManager.new_game()


func _on_credits_pressed() -> void:
	GameManager.credits_menu()


func _on_exit_game_pressed() -> void:
	GameManager.quit()
