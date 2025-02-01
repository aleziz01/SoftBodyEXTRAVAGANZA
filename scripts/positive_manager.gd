extends Node2D


func _ready() -> void:
	await get_tree().create_timer(1).timeout
	run()

var rng=RandomNumberGenerator.new()
func run() -> void:
	while(!global.gameWon):
		await get_tree().create_timer(0.1).timeout
		#have separate spawn functions for all positive objects.
		if(get_tree().paused==false and !global.gameOver and global.gameStarted and !global.paused):
			if global.score<4500:
				scoreSpawner(scoreStar1,global.score)
				scoreSpawner(scoreStar1,global.score)
				scoreSpawner(scoreStar1,global.score)
			if global.score<25000:
				scoreSpawner(scoreStar5,(global.score-2000)/3)
				scoreSpawner(scoreStar5,(global.score-2000)/3)
				scoreSpawner(scoreStar5,(global.score-2000)/3)
			if global.score<50000:
				scoreSpawner(scoreStar25,(global.score-5000)/7)
				scoreSpawner(scoreStar25,(global.score-5000)/7)
				scoreSpawner(scoreStar25,(global.score-5000)/7)
			if global.score<100000:
				scoreSpawner(scoreStar50,(global.score-10000)/10)
				scoreSpawner(scoreStar50,(global.score-10000)/10)
				scoreSpawner(scoreStar50,(global.score-10000)/10)
			scoreSpawner(scoreStar100,(global.score-20000)/13)
			scoreSpawner(scoreStar100,(global.score-20000)/13)
			scoreSpawner(scoreStar100,(global.score-20000)/13)
			scoreSpawner(scoreStar400,(global.score-45000)/20)
			#powerUpSpawns
			noCdPowerupSpawn()

var scoreStar1=preload("res://scenes/1ScoreStar.tscn")
var scoreStar5=preload("res://scenes/5ScoreStar.tscn")
var scoreStar25=preload("res://scenes/25ScoreStar.tscn")
var scoreStar50=preload("res://scenes/50ScoreStar.tscn")
var scoreStar100=preload("res://scenes/100ScoreStar.tscn")
var scoreStar400=preload("res://scenes/400ScoreStar.tscn")

var noCdPowerup=preload("res://scenes/NoCDPowerup.tscn")

@onready var scoreStarsHolder: Node2D = $ScoreStars
@onready var mainSoftBody: Node2D = $"../mainSoftBody"

func noCdPowerupSpawn():
	var DecisiveNumber=rng.randi_range(0,1000000/clamp(global.Upgrades[5]+1,1,12))
	if DecisiveNumber<clamp((global.score)/2,0,2000):
		var noCdPowerupInstance=noCdPowerup.instantiate()
		noCdPowerupInstance.global_position=Vector2(0,mainSoftBody.realPos.y)-Vector2(randf_range(-560,560),randf_range(1000,3000))
		noCdPowerupInstance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		scoreStarsHolder.add_child(noCdPowerupInstance)

func scoreSpawner(spawnedStar,condition):
	var DecisiveNumber=rng.randi_range(0,8000/clamp(global.Upgrades[5]+1,1,12))
	if (DecisiveNumber<clamp(condition,0,2000)):
		var scoreStarInstance=spawnedStar.instantiate()
		scoreStarInstance.global_position=Vector2(0,mainSoftBody.realPos.y)-Vector2(randf_range(-560,560),randf_range(1000,3000))
		scoreStarInstance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		scoreStarsHolder.add_child(scoreStarInstance)
