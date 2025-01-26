extends Bubble

@export var size_factor := 5
@onready var enemy_counter: Label = %EnemyCounter
var _cooldown := false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not _cooldown and event is InputEventMouseButton and event.is_pressed():
		_cooldown = true
		create_tween().tween_property(self, "bubble_scale", bubble_scale - 0.2, 0.1)
		wobble()
		await get_tree().create_timer(0.2).timeout
		_cooldown = false

	if roundi(bubble_scale * size_factor ) < 1:
		enemy_counter.hide() 
		pop()


func _update_size() -> void:
	super._update_size() 
	enemy_counter.text = "%s" % roundi(bubble_scale * size_factor)
