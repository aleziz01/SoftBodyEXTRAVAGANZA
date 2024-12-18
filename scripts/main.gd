extends Node2D

var explosion=preload("res://scenes/explosion.tscn")
@onready var cooldownBar: TextureProgressBar = $Hud/CooldownBar
@onready var timer: Timer = $Hud/CooldownBar/Timer

func _enter_tree() -> void:
	global.loadGame()

var cooldown=false
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("explode") and (!cooldown or global.noCD) and !global.gameOver and global.gameStarted:
		if(!global.noCD): #fixes bugs
			cooldown=true
			cooldownBar.value=0
			cooldownBar.show()
			timer.start()
		var explosionInstance=explosion.instantiate()
		explosionInstance.global_position=get_global_mouse_position()
		add_child(explosionInstance)
		if(!global.noCD): #fixes bugs
			await get_tree().create_timer(0.7).timeout
			cooldown=false
			timer.stop()

@onready var softBody=$mainSoftBody
@onready var camera: Camera2D = $Hud
@onready var meters_traveled: RichTextLabel = $Hud/MetersTraveled
@onready var scoreShower: Label = $Hud/ScoreShower

func _process(_delta: float) -> void:
	if camera and camera.global_position.y-softBody.realPos<-450 and !global.gameOver:
		global.gameOver=true
		gameover()
	meters_traveled.text="METERS:"+str(global.score+1)
	scoreShower.text="STARS EARNED:"+str(global.starScore)

@onready var gameOverSprite: Sprite2D = $Hud/GAMEOVER
@onready var highest_score: RichTextLabel = $Hud/GAMEOVER/HighestScore

signal GameOver
func gameover():
	emit_signal("GameOver")
	highest_score.text="Meters traveled: " + str(global.maxScore)
	global.fadeIn(gameOverSprite)
