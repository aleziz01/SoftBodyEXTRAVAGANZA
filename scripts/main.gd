extends Node2D

var explosion=preload("res://scenes/explosion.tscn")
@onready var cooldownBar: TextureProgressBar = $Hud/CooldownBar
@onready var timer: Timer = $Hud/CooldownBar/Timer

var cooldown=false
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("explode") and !cooldown and !global.gameOver:
		cooldown=true
		cooldownBar.value=0
		cooldownBar.show()
		timer.start()
		var explosionInstance=explosion.instantiate()
		explosionInstance.global_position=get_global_mouse_position()
		add_child(explosionInstance)
		await get_tree().create_timer(0.7).timeout
		cooldown=false
		timer.stop()
	if Input.is_action_just_pressed("pause"):
		get_tree().paused=true
		global.paused=true
		checkForUnpause()

func checkForUnpause():
	await get_tree().create_timer(0.05).timeout
	while(get_tree().paused):
		if Input.is_action_just_pressed("pause"):
			get_tree().paused=false
			global.paused=false
		await get_tree().create_timer(0.01).timeout

@onready var softBody=$mainSoftBody
@onready var camera: Camera2D = $Hud
@onready var meters_traveled: RichTextLabel = $Hud/MetersTraveled

func _process(_delta: float) -> void:
	if camera and camera.global_position.y-softBody.realPos<-450 and !global.gameOver:
		global.gameOver=true
		gameover()
	meters_traveled.text="METERS:"+str(global.score+1)

@onready var gameOverSprite: Sprite2D = $Hud/GAMEOVER
@onready var highest_score: RichTextLabel = $Hud/GAMEOVER/HighestScore

func gameover():
	highest_score.text="Meters traveled: " + str(global.maxScore)
	while gameOverSprite.modulate.a<1:
		gameOverSprite.modulate.a+=1.0/255.0*float(!global.paused)
		await get_tree().create_timer(0.01).timeout
