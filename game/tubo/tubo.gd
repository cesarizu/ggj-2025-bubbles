extends Node2D

@onready var cpu_particles_2d: CPUParticles2D = %CPUParticles2D

var bubble: Bubble

func _process(delta: float) -> void:
	cpu_particles_2d.emitting = Input.is_action_pressed(&"blow")

	if bubble and cpu_particles_2d.emitting:
		bubble.blow_up(5.0 * bubble.position.y / get_viewport_rect().size.y * delta)


func _on_push_area_2d_body_entered(body: Node2D) -> void:
	if body is Bubble:
		bubble = body


func _on_push_area_2d_body_exited(body: Node2D) -> void:
	if body is Bubble:
		bubble = null
