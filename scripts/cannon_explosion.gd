extends Area2D

func _ready() -> void:
	$GPUParticles2D.emitting=true

func _on_disable_collision_timeout() -> void:
	gravity=0
	set_collision_mask_value(1,false)
	set_collision_layer_value(1,false)

func _on_killtimer_timeout() -> void:
	queue_free()
