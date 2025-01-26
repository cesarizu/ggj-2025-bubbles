extends CanvasLayer

@onready var continue_game: Button = %ContinueGame


func _ready() -> void:
	continue_game.grab_focus.call_deferred()


func _exit_tree() -> void:
	GameManager.pause(false)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"pause"):
		_on_continue_game_pressed()


func _on_continue_game_pressed() -> void:
	queue_free()


func _on_back_to_main_menu_pressed() -> void:
	GameManager.main_menu()
	queue_free()
