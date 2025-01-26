class_name World
extends Node2D

const SPIKE = preload("res://game/spike/spike.tscn")
const PIPE = preload("res://game/tubo/tubo.tscn")

@export var pipe_density := 0.5  #between 0.0 and 1.0

@onready var background: Sprite2D = $background

static var instance: World

var cur_spikes = []
var cur_pipes = []
var speed := 100
var tile_width := 420
var tiles_in_screen_width := 6

var respawn_bias = 0


func _enter_tree() -> void:
	instance = self


func _exit_tree() -> void:
	instance = null


func _ready():
	instantiate_spikes()
	instantiate_pipes()


func _process(delta: float) -> void:
	move_spikes(delta)
	move_background(delta)
	move_pipes(delta)


func move_pipes(delta: float):
	for pipe in cur_pipes:
		pipe.position.x -= speed * delta
		if pipe.position.x < -200:
			cur_pipes.erase(pipe)
			pipe.queue_free()


func move_spikes(delta: float):
	for spike in cur_spikes:
		spike.position.x -= speed * delta
		if spike.position.x < -tile_width/2:
			spike.position.x = (tile_width) * tiles_in_screen_width - tile_width/2
			spike._ready()


func move_background(delta: float):
	background.region_rect.position.x += speed/2 * delta


func instantiate_pipes():
	for i in range(3):
		var pipe = PIPE.instantiate()
		pipe.position.y = 1080
		pipe.position.x = 1920/3 * (i + 1) - 100 #100 is bias
		add_child(pipe)
		cur_pipes.append(pipe)


func instantiate_spikes():
	for i in range(tiles_in_screen_width):
		var spike = SPIKE.instantiate()
		spike.position.y = 870
		spike.position.x = tile_width * i
		add_child(spike)
		cur_spikes.append(spike)
	for i in range(tiles_in_screen_width):
		var spike = SPIKE.instantiate()
		spike.position.y = 210
		spike.position.x = tile_width * i
		spike.rotation_degrees = 180
		add_child(spike)
		cur_spikes.append(spike)


func _on_timer_timeout() -> void:
	if randf() < pipe_density  * (respawn_bias * 0.5):
		var pipe = PIPE.instantiate()
		pipe.position.y = 1080
		pipe.position.x = 2000
		add_child(pipe)
		cur_pipes.append(pipe)
		respawn_bias = 0
	else:
		respawn_bias += 1
