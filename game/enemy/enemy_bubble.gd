extends Bubble

@export var min_size := 3
@export var size_factor := 5.0

@onready var enemy_counter: Label = %EnemyCounter

var _cooldown := false

var enemy_size: int:
	get:
		return roundi(bubble_scale * size_factor) - min_size


func _ready() -> void:
	super._ready()
	bubble_scale = (min_size + randi_range(1, 7)) / size_factor
	_update_size()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not _cooldown and event is InputEventMouseButton and event.is_pressed():
		_cooldown = true
		create_tween().tween_property(self, "bubble_scale", bubble_scale - 1 / size_factor, 0.1)
		wobble()
		await get_tree().create_timer(0.2).timeout
		_cooldown = false

	if enemy_size < 1:
		enemy_counter.hide()
		pop()


func pop() -> void:
	super.pop()
	enemy_counter.hide()


func _update_size() -> void:
	super._update_size()
	enemy_counter.text = "%s" % enemy_size
	if enemy_size < 1.0:
		pop()
