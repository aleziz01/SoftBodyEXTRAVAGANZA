extends Area2D

func _on_timer_timeout() -> void:
	queue_free()

func _on_layer1_entered(body: Node2D) -> void: #makes it so that when the bodies Stop Moving EXPLOSIONS affect Them.
	var tempAngle=get_angle_to(body.global_position)
	if !(body is StaticBody2D):
		body.linear_velocity+=Vector2(cos(tempAngle),sin(tempAngle))
