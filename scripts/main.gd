extends Node2D

var explosion=preload("res://scenes/explosion.tscn")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("explode"):
		var explosionInstance=explosion.instantiate()
		explosionInstance.global_position=get_global_mouse_position()
		add_child(explosionInstance)

@onready var softBody=$mainSoftBody
@onready var camera: Camera2D = $Camera

func _process(delta: float) -> void:
	if camera and camera.global_position.y-softBody.realPos<-450 and !global.gameOver:
		global.gameOver=true
		gameover()

@onready var gameOverSprite: Sprite2D = $Camera/Sprite2D
func gameover():
	while gameOverSprite.modulate.a<1:
		gameOverSprite.modulate.a+=1.0/255.0
		await get_tree().create_timer(0.01).timeout
