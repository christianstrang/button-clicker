extends Node
	
@onready var click_sound: AudioStreamPlayer = $ClickSound
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
	
func _on_pressed():
	cpu_particles_2d.global_position = get_viewport().get_mouse_position()
	cpu_particles_2d.restart()
	cpu_particles_2d.emitting = true
	
	
	# Random pitch between 0.8 and 1.2
	click_sound.pitch_scale = randf_range(0.92, 1.08)
	click_sound.play()
	
	# Call score increment
	GameManager.increment_score()
