extends Node2D

const SPIKE = preload("res://game/spike/spike.tscn")

var cur_spikes:Array[Spike] = []
@export var speed := 100.0
@export var tile_width := 420
@export var tiles_in_screen_width := 6

func _ready():
	for i in range(tiles_in_screen_width):
		var spike:Spike = SPIKE.instantiate()
		spike.position.y = 870
		spike.position.x = tile_width * i
		add_child(spike)
		cur_spikes.append(spike)
	for i in range(tiles_in_screen_width):
		var spike:Spike = SPIKE.instantiate()
		spike.position.y = 210
		spike.position.x = tile_width * i
		spike.rotation_degrees = 180
		add_child(spike)
		cur_spikes.append(spike)

func _process(delta: float) -> void:
	for spike in cur_spikes:
		spike.position.x -= speed * delta
		if spike.position.x < -tile_width/2:
			spike.position.x = (tile_width) * tiles_in_screen_width - tile_width/2
			spike.set_random_texture()
