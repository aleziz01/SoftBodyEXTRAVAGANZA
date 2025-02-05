extends Area2D
var ok=true
var audio=true

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	if !global.gameStarted:
		set_collision_mask_value(1,false)
		set_collision_layer_value(1,false)
	if ok:
		global.selfDestructHP-=1
	if audio_stream_player and audio:
		audio_stream_player.play()

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
	if parentOfBody.name!="MainSoftBody" and !(body is StaticBody2D):
		body.linear_velocity+=Vector2(cos(tempAngle)*40000,sin(tempAngle)*40000)
