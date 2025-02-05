extends Area2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	audio_stream_player.volume_db=randf_range(7,10)
	audio_stream_player.pitch_scale=randf_range(1.5,2)
	audio_stream_player.play(0.62)
	$GPUParticles2D.emitting=true

func _on_disable_collision_timeout() -> void:
	gravity=0
	set_collision_mask_value(1,false)
	set_collision_layer_value(1,false)

func _on_killtimer_timeout() -> void:
	queue_free()
