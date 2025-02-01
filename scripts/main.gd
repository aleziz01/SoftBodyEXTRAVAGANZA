extends Node2D

var explosion=preload("res://scenes/explosion.tscn")
@onready var cooldownBar: TextureProgressBar = $Hud/CooldownBar
@onready var timer: Timer = $Hud/CooldownBar/Timer

func _enter_tree() -> void:
	global.loadGame()
	changeCursor()
	Input.set_custom_mouse_cursor(normalCursor,Input.CURSOR_ARROW,Vector2(16,16))

var explosionCursor=preload("res://art/explosionCursorTexture.png")
var normalCursor = preload("res://art/cursorTexture.png")

var cooldown=false
var switchingTex=false
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

func changeCursor():
	while(true):
		if Input.is_action_just_pressed("explode") and !switchingTex:
			Input.set_custom_mouse_cursor(explosionCursor,Input.CURSOR_ARROW,Vector2(16,16))
			switchingTex=true
			await get_tree().create_timer(0.05).timeout
			Input.set_custom_mouse_cursor(normalCursor,Input.CURSOR_ARROW,Vector2(16,16))
			switchingTex=false
		await get_tree().create_timer(0.001).timeout

@onready var softBody=$mainSoftBody
@onready var camera: Camera2D = $Hud
@onready var meters_traveled: RichTextLabel = $Hud/MetersTraveled
@onready var starScoreShower: Label = $Hud/ScoreShower
@onready var second_life_cooldown_timer: Timer = $secondLifeCooldown
@onready var mainSoftBody: Node2D = $mainSoftBody

var secondLifeCooldown=false
var savingExplosion=preload("res://scenes/savingExplosion.tscn")
var winningChamber=preload("res://scenes/winningChamber.tscn")

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
	if !global.gameWon and global.score>global.winningDistance:
		global.gameWon=true
		var winningChamberInstance=winningChamber.instantiate()
		winningChamberInstance.global_position=Vector2(0,mainSoftBody.realPos.y)
		add_child(winningChamberInstance)
	meters_traveled.text="METERS:"+str(global.score+1)
	starScoreShower.text="STARS EARNED:"+str(global.starScore)

@onready var gameOverSprite: Sprite2D = $Hud/GAMEOVER

signal GameOver
func gameover():
	emit_signal("GameOver")
	global.fadeIn(gameOverSprite)

func _on_second_life_cooldown_timeout() -> void:
	secondLifeCooldown=false
