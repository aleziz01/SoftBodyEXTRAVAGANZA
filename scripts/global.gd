extends Node

var gameStarted:bool=false
var gameOver=false
var score:int=0
var maxScore:int=0
var HighScore:int=0
var starScore:int=0
var paused:bool=false
var Upgrades=[0,0,0,0,0,0,0,0,0,0]
var StarUpgradesPlus=[1,3,7,15,0,15,0,50]
var StarUpgradesTimes=[1,1,1,1,2,2,4,4]
var noCD=false
var Explosion1Done=false

var selfDestructHP=0
var secondLives=0

func _ready() -> void:
	selfDestructHP=Upgrades[3]
	secondLives=Upgrades[7]

func _process(_delta: float) -> void:
	maxScore=max(score,maxScore)

func switchFades(node1,node2):
	fadeIn(node1)
	fadeOut(node2)

func fadeOut(node):
	while(node.modulate.a>0.0):
		node.modulate.a-=0.01
		await get_tree().create_timer(0.01).timeout

func fadeIn(node):
	while(node.modulate.a<=1.0):
		node.modulate.a+=0.01
		await get_tree().create_timer(0.01).timeout

func save():
	var save_dict={
		#global variables that save across playtimes
		"HighScore":max(maxScore,HighScore),
		"starScore":starScore,
		"Upgrades":Upgrades
	}
	return save_dict

func saveGame():
	var saveFile=FileAccess.open("user://savedgame.dat",FileAccess.WRITE)
	var saveData=save()
	var json_string=JSON.stringify(saveData)
	saveFile.store_line(json_string)

func loadGame():
	if not FileAccess.file_exists("user://savedgame.dat"):
		return #error!!! we dont have a save!
	var saveFile=FileAccess.open("user://savedgame.dat",FileAccess.READ)
	while(saveFile.get_position()<saveFile.get_length()):
		var json_string = saveFile.get_line()
		var json=JSON.new()
		var parseResult=json.parse(json_string)
		if not parseResult == OK:
			print("JSON PARSE ERROR", json.get_error_message()," in ", json_string, " at line ",json.get_error_line())
			continue
		var nodeData=json.data
		for i in nodeData.keys():
			global.set(i, nodeData[i])
	print(HighScore, " <-HighScore " ,maxScore, " <-MaxScore " , starScore, " <-StarScore ", Upgrades[0]," <-ExplosionSizeUpgrade ",
	Upgrades[1]," <-ExplosionPowerUpgrade ")

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		saveGame()
		await get_tree().create_timer(0.1).timeout
		get_tree().quit()
