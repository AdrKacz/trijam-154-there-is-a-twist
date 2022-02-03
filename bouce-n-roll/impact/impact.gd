extends Spatial

onready var audio_stream : AudioStreamPlayer3D = $AudioStreamPlayer3D
onready var particles : CPUParticles = $CPUParticles
var energy : float = 0

func _ready():
	audio_stream.unit_db = lerp(0, 10, energy / 100)
	particles.scale_amount = lerp(1, 5, energy / 100)
	particles.emitting = true
	audio_stream.is_playing = true

func _on_Timer_timeout():
	queue_free()
