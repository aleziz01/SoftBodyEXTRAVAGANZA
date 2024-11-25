extends Area2D

func _enter_tree() -> void:
	$GPUParticles2D.emitting=true
	if global.gameStarted==false:
		queue_free()

func _on_layer1_entered(body: Node2D) -> void: #makes it so that when the bodies Stop Moving EXPLOSIONS affect Them.
	var tempAngle=get_angle_to(body.global_position)
	if !(body is StaticBody2D):
		body.linear_velocity+=Vector2(cos(tempAngle),sin(tempAngle))

func _on_disable_collision_timeout() -> void:
	gravity=0
	set_collision_mask_value(1,false)
	set_collision_layer_value(1,false)


func _on_killtimer_timeout() -> void:
	queue_free()
