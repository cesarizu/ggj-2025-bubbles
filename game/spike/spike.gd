extends Node2D

class_name Spike

@export var sprites: Array[Texture2D] = []
var ran_index

func _ready() -> void:
	#turn off all spikes
	for col in $StaticBody2D.get_children():
		col.disabled = true
		col.visible = false
	
	ran_index = randi_range(0, 4)
	$Sprite2D.texture = sprites[ran_index]
	$StaticBody2D.get_child(ran_index).disabled = false
	$StaticBody2D.get_child(ran_index).visible = true

func _process(delta: float) -> void:
	pass
