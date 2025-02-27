class_name Bubble
extends RigidBody2D

@export var is_player := true
@export var grow_factor := 2.0
@export var shrink_factor := -0.05
@export var blow_up_force := 50.0
@export var drip_down_force := 25.0
@export var puncture_factor := -0.2
@export var size_factor := 5.0
@export var min_size := 2
@export var max_size := 15

@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var circle_shape_2d: CircleShape2D = %CollisionShape2D.shape
@onready var gpu_particles_2d: GPUParticles2D = %GPUParticles2D

var _original_sprite_scale: Vector2
var _original_particles_scale: Vector2
var _original_radius: float

var _puncturing := false

var bubble_scale := 1.0:
	set(value):
		if value != bubble_scale:
			if value * size_factor > max_size:
				value = max_size / size_factor
			bubble_scale = value
			_update_size()

var bubble_size: int:
	get:
		return roundi(bubble_scale * size_factor) - min_size

var _wooble_id := 0

var _is_popped := false


func _ready() -> void:
	_original_sprite_scale = sprite_2d.scale
	_original_particles_scale = gpu_particles_2d.scale
	_original_radius = circle_shape_2d.radius
	_update_size()


func blow_up(amount: float, delta: float) -> void:
	apply_central_force(Vector2.UP * blow_up_force * mass * amount)
	scale_bubble(grow_factor * amount * delta)
	wobble()
	#$GrowAudioStreamPlayer2D.play()


func drip_down() -> void:
	apply_central_impulse(Vector2.DOWN * drip_down_force * mass)
	scale_bubble(shrink_factor)
	wobble()
	$DownAudioStreamPlayer2D2.play()


func puncture(direction: Vector2) -> void:
	if _puncturing:
		return

	_puncturing = true
	scale_bubble(puncture_factor)
	apply_central_impulse(direction * 200 * mass)
	await get_tree().create_timer(1).timeout
	_puncturing = false


func pop() -> void:
	if _is_popped:
		return
	_is_popped = true
	gpu_particles_2d.emitting = true
	sprite_2d.hide()
	$PlopAudioStreamPlayer2D.play()
	await get_tree().create_timer(2).timeout
	queue_free()


func scale_bubble(factor: float) -> void:
	var target := 1.0 + factor;

	create_tween().tween_property(self, "bubble_scale", bubble_scale * target, 0.1)


func wobble() -> void:
	_wooble_id += 1
	var wobble_id := _wooble_id
	var speed := 0.1
	var rand_dir: float = [1.0, -1.0].pick_random()

	for a in 10:
		var tween1 := create_tween()
		var tween2 := create_tween()

		var scale := Vector2.ONE * _original_sprite_scale * bubble_scale
		var factor := 0.2 / (a + 1)

		tween1.tween_property(sprite_2d, "skew", rand_dir * factor / 2, speed)
		tween1.tween_property(sprite_2d, "skew", 0, speed)
		tween1.tween_property(sprite_2d, "skew", rand_dir * -factor / 2, speed)
		tween1.tween_property(sprite_2d, "skew", 0, speed)

		tween2.tween_property(sprite_2d, "scale", scale * Vector2(1 + factor, 1), speed)
		tween2.tween_property(sprite_2d, "scale", scale, speed)
		tween2.tween_property(sprite_2d, "scale", scale * Vector2(1, 1 + factor), speed)
		tween2.tween_property(sprite_2d, "scale", scale, speed)

		await tween1.finished
		await tween2.finished

		if _wooble_id != wobble_id:
			return

		speed *= 0.9


func _update_size() -> void:
	sprite_2d.scale = _original_sprite_scale * bubble_scale
	gpu_particles_2d.scale = _original_particles_scale * bubble_scale
	circle_shape_2d.radius = _original_radius * bubble_scale

	if is_player:
		AudioManager.intensity = 1.0 - clampf(bubble_size / 6.0, 0.0, 1.0)

	if bubble_size < 1.0:
		pop()

		if is_player:
			AudioManager.game_over()
			await get_tree().create_timer(2).timeout
			GameManager.game_over()


func _on_body_entered(body: Node) -> void:
	$DownAudioStreamPlayer2D2.play()
	wobble()

	if is_player and body is Bubble and not body.is_player:
		puncture((position - body.position).normalized())
