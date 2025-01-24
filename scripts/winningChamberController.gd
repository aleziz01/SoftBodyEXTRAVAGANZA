extends Node2D

@onready var coin: Sprite2D = $Coin
var burntShader=preload("res://shaders/burntShader.gdshader")
var burntNoise=preload("res://shaders/BurntNoiseImg.tres")

func _ready() -> void:
	global.wins+=1
	$TextController/VBoxContainer/StarsEarnedFromRun.text="Stars earned this run: " + str(global.starScore-global.initialStarScore)
	$TextController/VBoxContainer/StarsEarnedFromWinning.text="You got an extra " + str(global.winningDistance) + " stars!"
	global.starScore+=global.winningDistance
	$TextController/VBoxContainer/Time.text="Time: " + str(global.time[0]) + "h " + str(global.time[1]) + "m " + str(global.time[2]) + "s"
	coin.material=ShaderMaterial.new()
	match global.wins:
		1:
			coin.material.shader=burntShader
			coin.material.set_shader_parameter("noise_img",burntNoise)
			$Coin/CoinType.text="Burnt Coin!"
		2:
			pass
		3:
			pass
