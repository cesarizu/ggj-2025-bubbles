class_name Spike
extends Node2D

var _is_upside_down := false


func rotate_spike(upside_down: bool) -> void:
	_is_upside_down = upside_down
	rotation_degrees = 180 if upside_down else 0
	%Drop.visible = upside_down
	%Drop.process_mode = Node.PROCESS_MODE_INHERIT if upside_down else Node.PROCESS_MODE_DISABLED


func _on_point_area_2d_body_entered(body: Node2D) -> void:
	if body is Bubble:
		body.puncture(Vector2.DOWN if _is_upside_down else Vector2.UP)
