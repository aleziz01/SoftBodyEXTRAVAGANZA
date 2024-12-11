extends Node2D


func _ready() -> void:
	run()

var rng=RandomNumberGenerator.new()
func run() -> void:
	while(true):
		await get_tree().create_timer(0.1).timeout
		#have separate spawn functions for all positive objects.
		if(get_tree().paused==false and !global.gameOver and global.gameStarted):
			if global.score<4500:
				score1Spawn()
				score1Spawn()
				score1Spawn()
			if global.score<12500:
				score5Spawn()
				score5Spawn()
				score5Spawn()
			if global.score<25000:
				score25Spawn()
				score25Spawn()
				score25Spawn()
			if global.score<50000:
				score50Spawn()
				score50Spawn()
				score50Spawn()
			score100Spawn()
			score100Spawn()
			score100Spawn()
			score400Spawn()
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

func noCdPowerupSpawn(): #0.02% chance to spawn every 10th of a second max
	var DecisiveNumber=rng.randi_range(0,1000000/(global.Upgrades[5]+1))
	if DecisiveNumber<=clamp((global.score)/2,0,2000):
		var noCdPowerupInstance=noCdPowerup.instantiate()
		noCdPowerupInstance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-560,560),randf_range(1000,3000))
		noCdPowerupInstance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		scoreStarsHolder.add_child(noCdPowerupInstance)

func score1Spawn():
	var DecisiveNumber=rng.randi_range(0,3000)
	if DecisiveNumber<=clamp((global.score),0,2000):
		var scoreStar1Instance=scoreStar1.instantiate()
		scoreStar1Instance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-560,560),randf_range(1000,3000))
		scoreStar1Instance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		scoreStarsHolder.add_child(scoreStar1Instance)

func score5Spawn():
	var DecisiveNumber=rng.randi_range(0,3000)
	if DecisiveNumber<clamp((global.score-2000)/3,0,2000):
		var scoreStar5Instance=scoreStar5.instantiate()
		scoreStar5Instance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-560,560),randf_range(1000,3000))
		scoreStar5Instance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		scoreStarsHolder.add_child(scoreStar5Instance)

func score25Spawn():
	var DecisiveNumber=rng.randi_range(0,3000)
	if DecisiveNumber<clamp((global.score-5000)/7,0,2000):
		var scoreStar25Instance=scoreStar25.instantiate()
		scoreStar25Instance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-560,560),randf_range(1000,3000))
		scoreStar25Instance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		scoreStarsHolder.add_child(scoreStar25Instance)

func score50Spawn():
	var DecisiveNumber=rng.randi_range(0,3000)
	if DecisiveNumber<clamp((global.score-10000)/10,0,2000):
		var scoreStar50Instance=scoreStar50.instantiate()
		scoreStar50Instance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-560,560),randf_range(1000,3000))
		scoreStar50Instance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		scoreStarsHolder.add_child(scoreStar50Instance)

func score100Spawn():
	var DecisiveNumber=rng.randi_range(0,3000)
	if DecisiveNumber<clamp((global.score-20000)/13,0,2000):
		var scoreStar100Instance=scoreStar100.instantiate()
		scoreStar100Instance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-560,560),randf_range(1000,3000))
		scoreStar100Instance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		scoreStarsHolder.add_child(scoreStar100Instance)

func score400Spawn():
	var DecisiveNumber=rng.randi_range(0,3000)
	if DecisiveNumber<clamp((global.score-45000)/20,0,2000):
		var scoreStar400Instance=scoreStar400.instantiate()
		scoreStar400Instance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-560,560),randf_range(1000,3000))
		scoreStar400Instance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		scoreStarsHolder.add_child(scoreStar400Instance)
