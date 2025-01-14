extends Area2D

func _ready() -> void:
	global.Upgrades[2]-=1

func _enter_tree() -> void:
	$GPUParticles2D.emitting=true

func _on_disable_collision_timeout() -> void:
	gravity=(global.Upgrades[3]%3)*50000
	set_collision_mask_value(1,false)
	set_collision_layer_value(1,false)

func _on_killtimer_timeout() -> void:
	queue_free()

func _on_body_entered(body):
	var parentOfBody=body.get_parent().get_parent()
	var tempAngle=get_angle_to(body.global_position)
	if parentOfBody.name=="Node2D":
		body.linear_velocity+=Vector2(cos(tempAngle)*500000,sin(tempAngle)*500000)
