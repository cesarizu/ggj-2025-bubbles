extends Sprite2D

@onready var cpu_particles_2d: CPUParticles2D = %CPUParticles2D

var bubble: Bubble


func _process(delta: float) -> void:
	if bubble and cpu_particles_2d.emitting:
		print(bubble.position.y)
		bubble.blow_up(5.0 * delta)


func _on_click_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			cpu_particles_2d.emitting = event.pressed


func _on_push_area_2d_body_entered(body: Node2D) -> void:
	if body is Bubble:
		bubble = body


func _on_push_area_2d_body_exited(body: Node2D) -> void:
	if body is Bubble:
		bubble = null
