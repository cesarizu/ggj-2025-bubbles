class_name Drop
extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var _dripping := false
var bubble: Bubble


func _on_click_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if _dripping:
		return

	if event is InputEventMouseButton and event.is_pressed():
		animated_sprite_2d.play("drip1")
		_dripping = true
		await get_tree().create_timer(1).timeout
		animated_sprite_2d.play("still")
		_dripping = false


func _process(delta: float) -> void:
	if bubble and _dripping:
		bubble.drip_down()


func _on_drop_area_2d_body_entered(body: Node2D) -> void:
	if body is Bubble:
		bubble = body


func _on_drop_area_2d_body_exited(body: Node2D) -> void:
	if body is Bubble:
		bubble = null
