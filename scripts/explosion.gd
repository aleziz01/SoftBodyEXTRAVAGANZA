extends Area2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var audio=true
#apply all upgrades to the explosion
func _ready() -> void:
	if audio and audio_stream_player and !global.noCD:
		audio_stream_player.pitch_scale*=randf_range(0.5,1)
		audio_stream_player.play()
	if(global.Upgrades[8] and global.Explosion1Done==false and global.gameStarted):
		gravity-=global.Upgrades[8]*100000
		scale=Vector2(2,2)
		global.Explosion1Done=true
	else:
		scale=Vector2(1.0+global.Upgrades[0]/20.0,1.0+global.Upgrades[0]/20.0) #apply the explosionSize Upgrade
		gravity-=2000*pow(2,global.Upgrades[1]-1)*int(global.gameStarted)
		gravity+=(1/(1.0-global.Upgrades[9]/20.0))*gravity

func _enter_tree() -> void:
	$GPUParticles2D.emitting=true

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
