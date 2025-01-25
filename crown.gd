extends Sprite2D

@export var mainSoftBody:Node2D
var speed=0

func _ready() -> void:
	changeRot()

func _process(delta: float) -> void:
	speed=clamp(speed,-0.5,0.5)
	global_position=mainSoftBody.realPos-Vector2(0,99)
	rotation_degrees+=speed

func changeRot():
	while(true):
		for i in 10000:
			rotation=sin(deg_to_rad(i))/10.0
			await get_tree().create_timer(0.01).timeout
