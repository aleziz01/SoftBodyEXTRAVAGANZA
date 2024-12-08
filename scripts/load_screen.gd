extends Polygon2D

func _ready() -> void:
	resetStats()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func resetStats():
	global.gameStarted=false
	global.gameOver=false
	global.score=0
	global.maxScore=0
	global.HighScore=0
	global.starScore=0
	global.paused=false
	global.Upgrades=[0,0,0,0,0,0,0,0,0,0]
