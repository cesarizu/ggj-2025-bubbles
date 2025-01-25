class_name Bubble
extends RigidBody2D

@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var circle_shape_2d: CircleShape2D = %CollisionShape2D.shape

var _original_scale: Vector2
var _original_radius: float

var bubble_scale := 1.0:
	set(value):
		if value != bubble_scale:
			bubble_scale = value
			_update_size()

var _wooble_id := 0


func _ready() -> void:
	_original_scale = sprite_2d.scale
	_original_radius = circle_shape_2d.radius


func scale_bubble(factor: float) -> void:
	var tween := create_tween()
	tween.parallel().tween_property(self, "bubble_scale", bubble_scale * factor, 0.1)


func blow_up() -> void:
	apply_central_impulse(Vector2.UP * 50)
	wobble()


func wobble() -> void:
	_wooble_id += 1
	var wobble_id := _wooble_id
	var speed := 0.1
	var rand_dir: float = [1.0, -1.0].pick_random()

	for a in 10:
		var tween1 := create_tween()
		var tween2 := create_tween()

		var scale := Vector2.ONE * _original_scale * bubble_scale
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
	sprite_2d.scale = _original_scale * bubble_scale
	circle_shape_2d.radius = _original_radius * bubble_scale


func _on_body_entered(body: Node) -> void:
	wobble()
