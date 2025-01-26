class_name Spike
extends Node2D


func rotate_spike(upside_down: bool) -> void:
	rotation_degrees = 180 if upside_down else 0
	%Drop.visible = upside_down
	%Drop.process_mode = Node.PROCESS_MODE_INHERIT if upside_down else Node.PROCESS_MODE_DISABLED
