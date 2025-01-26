extends Node2D

class_name Spike

const DROP = preload("res://game/drop/drop.tscn")
var is_upwards = false
@export var drop_spawn_probability = 0.3
@export var sprites: Array[Texture2D] = []
var ran_index

func _ready() -> void:
	turn_off_all_pipes()
	ran_index = randi_range(0, 4)

	set_texture_and_collider(ran_index)
	if is_upwards:
		instanciate_drop(ran_index)

func set_texture_and_collider(index:int):
	$Sprite2D.texture = sprites[index]
	$StaticBody2D.get_child(index).disabled = false
	$StaticBody2D.get_child(index).visible = true

func turn_off_all_pipes():
	for col in $StaticBody2D.get_children():
		col.disabled = true
		col.visible = false


func instanciate_drop(ran_index:int):
	if randf() < drop_spawn_probability:
		var dp = DROP.instantiate()
		var trans:Transform2D = $StaticBody2D.get_child(ran_index).get_child(0).transform
		dp.transform = trans
		add_child(dp)
