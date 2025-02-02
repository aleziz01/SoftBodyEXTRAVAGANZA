extends Node2D

@onready var coin: Sprite2D = $Coin
var burntShader=preload("res://shaders/burntShader.gdshader")
var burntNoise=preload("res://shaders/BurntNoiseImg.tres")
var deepSeaShader=preload("res://shaders/DeepSea.gdshader")
var deepSeaNoise=preload("res://shaders/DeepSea.tres")
var RoyalShader=preload("res://shaders/royal.gdshader")

func _ready() -> void:
	global.wins+=1
	$TextController/VBoxContainer/StarsEarnedFromRun.text="STARS EARNED THIS RUN: " + str(global.starScore-global.initialStarScore)
	$TextController/VBoxContainer/StarsEarnedFromWinning.text="YOU GOT AN EXTRA " + str(global.winningDistance) + " STARS!"
	global.starScore+=global.winningDistance
	$TextController/VBoxContainer/Time.text="TIME: " + str(global.time[0]) + "H " + str(global.time[1]) + "M " + str(global.time[2]) + "S"
	$TextController/VBoxContainer/NrWins.text="TOTAL WINS: " + str(global.wins) 
	coin.material=ShaderMaterial.new()
	if global.wins==1:
		coin.material.shader=burntShader
		coin.material.set_shader_parameter("noise_img",burntNoise)
		$Coin/CoinType.text="BURNT COIN!"
	elif global.wins==2:
		coin.material.shader=deepSeaShader
		coin.material.set_shader_parameter("noise_img",deepSeaNoise)
		$Coin/CoinType.text="DEEP SEA COIN!"
	elif global.wins==3:
		setBestTime()
		$Coin/CoinType.text="ROYAL COIN!"
		coin.material.shader=RoyalShader
	if global.wins>=3:
		calculateBestTime()
		$TextController/VBoxContainer/BestTime.text="BEST TIME: " + str(global.BestTime[0]) + "H " + str(global.BestTime[1]) + "M " + str(global.BestTime[2]) + "S"
		$TextController/VBoxContainer/BestTime.show()
		$TextController/VBoxContainer/Time.show()
		$Coin/CoinType.text=str(global.wins*global.winningDistance) + " STARS!"
		$Coin/CoinType.global_position+=Vector2(60,20)
		global.starScore+=global.winningDistance*global.wins

func calculateBestTime():
	if global.time[0]<global.BestTime[0]:
		setBestTime()
	elif global.time[1]<global.BestTime[1]:
		setBestTime()
	elif global.time[2]<global.BestTime[2]:
		setBestTime()

func setBestTime():
	global.BestTime[0]=global.time[0]
	global.BestTime[1]=global.time[1]
	global.BestTime[2]=global.time[2]

func _on_quit_button_pressed() -> void:
	global.saveGame()
	await get_tree().create_timer(0.005).timeout
	get_tree().quit()

func _on_retry_button_pressed() -> void:
	get_tree().paused=false
	global.paused=false
	global.saveGame()
	await get_tree().create_timer(0.005).timeout
	get_tree().change_scene_to_file("res://scenes/load_screen.tscn")
