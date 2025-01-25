extends Area2D

@onready var particles: CPUParticles2D = $CPUParticles2D

func _input_event(viewport, event, shape_idx):
	# Detecta si el evento es un clic del mouse
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Activa el CPUParticles2D al presionar el clic
				particles.emitting = true
			else:
				# Desactiva el CPUParticles2D al soltar el clic
				particles.emitting = false
