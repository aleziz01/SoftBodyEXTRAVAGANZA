extends Node2D

var explosion=preload("res://scenes/explosion.tscn")
@onready var cooldownBar: TextureProgressBar = $Hud/CooldownBar
@onready var timer: Timer = $Hud/CooldownBar/Timer

func _enter_tree() -> void:
	global.loadGame()

var cooldown=false
func _input(_event: InputEvent) -> void:
	if (Input.is_action_just_pressed("explode") or (Input.is_action_pressed("explode") and global.noCD)) and (!cooldown or global.noCD) and !global.gameOver and global.gameStarted:
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
@onready var second_life_cooldown_timer: Timer = $secondLifeCooldown

var secondLifeCooldown=false
var savingExplosion=preload("res://scenes/savingExplosion.tscn")

func _process(_delta: float) -> void:
	if camera and camera.global_position.y-softBody.realPos.y<-550 and !global.gameOver and global.secondLives and !secondLifeCooldown:
		global.secondLives-=1
		var savingExplosionInstance=savingExplosion.instantiate()
		savingExplosionInstance.global_position=Vector2(0,softBody.realPos.y+200)
		savingExplosionInstance.gravity-=50000*global.Upgrades[7]
		softBody.add_child(savingExplosionInstance)
		secondLifeCooldown=true
		second_life_cooldown_timer.start()
	if camera and camera.global_position.y-softBody.realPos.y<-1000 and !global.gameOver and global.secondLives==0:
		global.gameOver=true
		gameover()
	meters_traveled.text="METERS:"+str(global.score+1)
	scoreShower.text="STARS EARNED:"+str(global.starScore)

@onready var gameOverSprite: Sprite2D = $Hud/GAMEOVER

signal GameOver
func gameover():
	emit_signal("GameOver")
	global.fadeIn(gameOverSprite)


func _on_second_life_cooldown_timeout() -> void:
	secondLifeCooldown=false
