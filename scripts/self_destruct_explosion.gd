extends Area2D
var ok=true
func _ready() -> void:
	if ok:
		global.selfDestructHP-=1

func _enter_tree() -> void:
	$GPUParticles2D.emitting=true

func _on_disable_collision_timeout() -> void:
	gravity=int(global.Upgrades[3])*50000
	set_collision_mask_value(1,false)
	set_collision_layer_value(1,false)

func _on_killtimer_timeout() -> void:
	queue_free()

func _on_body_entered(body):
	var parentOfBody=body.get_parent().get_parent()
	var tempAngle=get_angle_to(body.global_position)
	if parentOfBody.name=="Node2D":
		body.linear_velocity+=Vector2(cos(tempAngle)*500000,sin(tempAngle)*500000)
