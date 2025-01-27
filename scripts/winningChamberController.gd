extends Node2D

@onready var coin: Sprite2D = $Coin
var burntShader=preload("res://shaders/burntShader.gdshader")
var burntNoise=preload("res://shaders/BurntNoiseImg.tres")
var deepSeaShader=preload("res://shaders/DeepSea.gdshader")
var deepSeaNoise=preload("res://shaders/DeepSea.tres")
var RoyalShader=preload("res://shaders/royal.gdshader")

func _ready() -> void:
	global.wins+=1
	$TextController/VBoxContainer/StarsEarnedFromRun.text="Stars earned this run: " + str(global.starScore-global.initialStarScore)
	$TextController/VBoxContainer/StarsEarnedFromWinning.text="You got an extra " + str(global.winningDistance) + " stars!"
	global.starScore+=global.winningDistance
	$TextController/VBoxContainer/Time.text="Time: " + str(global.time[0]) + "h " + str(global.time[1]) + "m " + str(global.time[2]) + "s"
	$TextController/VBoxContainer/NrWins.text="Total Wins: " + str(global.wins) 
	coin.material=ShaderMaterial.new()
	if global.wins==1:
		coin.material.shader=burntShader
		coin.material.set_shader_parameter("noise_img",burntNoise)
		$Coin/CoinType.text="Burnt Coin!"
	elif global.wins==2:
		coin.material.shader=deepSeaShader
		coin.material.set_shader_parameter("noise_img",deepSeaNoise)
		$Coin/CoinType.text="Deep Sea Coin!"
	elif global.wins==3:
		setBestTime()
	if global.wins>=3:
		calculateBestTime()
		$TextController/VBoxContainer/BestTime.text="Best Time: " + str(global.BestTime[0]) + "h " + str(global.BestTime[1]) + "m " + str(global.BestTime[2]) + "s"
		$TextController/VBoxContainer/BestTime.show()
		$TextController/VBoxContainer/Time.show()

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
