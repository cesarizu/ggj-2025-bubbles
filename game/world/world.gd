class_name World
extends Node2D

const ENEMY = preload("res://game/enemy/enemy_bubble.tscn")
const PIPE = preload("res://game/tubo/tubo.tscn")

@export var spikes: Array[PackedScene] = []
@export var pipe_density := 0.5  #between 0.0 and 1.0

@onready var background: Sprite2D = $background
@onready var enemy_timer: Timer = $EnemySpawnTimer

static var instance: World

var cur_spikes = []
var cur_pipes = []
var cur_enemies: Array[Bubble] = []
var speed := 100
var tile_width := 420
var tiles_in_screen_width := 6

var respawn_bias = 0

var bubble: Bubble


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
	move_enemies(delta)
	blow_bubble(delta)


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


func move_background(delta: float):
	background.region_rect.position.x += speed/2 * delta


func move_enemies(delta: float):
	for enemy in cur_enemies:
		if not is_instance_valid(enemy):
			continue
		enemy.apply_central_force(0.25 * Vector2.LEFT)
		#enemy.position.x -= speed * delta
		if enemy.position.x < -500:
			cur_enemies.erase(enemy)
			enemy.queue_free()


func instantiate_pipes():
	for i in range(3):
		var pipe = PIPE.instantiate()
		pipe.position.y = 1080
		pipe.position.x = 1920/3 * (i + 1) - 100 #100 is bias
		add_child(pipe)
		cur_pipes.append(pipe)


func instantiate_spikes():
	for i in range(tiles_in_screen_width):
		var bottom_spike: Spike = spikes.pick_random().instantiate()
		bottom_spike.position.y = 1080
		bottom_spike.position.x = tile_width * i
		bottom_spike.rotate_spike(false)
		add_child(bottom_spike)
		cur_spikes.append(bottom_spike)

		var top_spike: Spike = spikes.pick_random().instantiate()
		top_spike.position.y = 0
		top_spike.position.x = tile_width * i
		top_spike.rotate_spike(true)
		add_child(top_spike)
		cur_spikes.append(top_spike)


func _on_enemy_spawn_timer_timeout() -> void:
	var enemy := ENEMY.instantiate()
	enemy.position = Vector2(2000.0, randf_range(300.0, 700.0))
	add_child(enemy)
	cur_enemies.append(enemy)


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


func blow_bubble(delta: float) -> void:
	if bubble:
		if bubble.position.x < 256.0:
			var amount := 1.0 - (bubble.position.x / 256.0)
			var force := amount * Vector2(1.0, -sign(bubble.position.y - 520))
			bubble.apply_central_force(200 * force * delta)
		elif bubble.position.x > 1700.0:
			var amount := (bubble.position.x - 1700.0) / 256.0
			var force := amount * Vector2(-1.0, -sign(bubble.position.y - 520))
			bubble.apply_central_force(200 * force * delta)


func _on_blow_area_2d_body_entered(body: Node2D) -> void:
	if body is Bubble and body.is_player:
		bubble = body as Bubble


func _on_blow_area_2d_body_exited(body: Node2D) -> void:
	bubble = null
