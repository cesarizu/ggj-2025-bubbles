extends Node2D

@onready var bubble: Bubble = $Bubble


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_SPACE:
		bubble.blow_up(1.0)

	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_BACKSPACE:
		bubble.drip_down()

	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_ESCAPE:
		bubble.pop()

	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_UP:
		bubble.scale_bubble(1.1)

	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_DOWN:
		bubble.scale_bubble(1.0 / 1.1)
