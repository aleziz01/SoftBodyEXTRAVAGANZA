extends Node2D


func _ready() -> void:
	run()

var rng=RandomNumberGenerator.new()
func run() -> void:
	while(true):
		await get_tree().create_timer(0.1).timeout
		#have separate spawn functions for all positive objects.
		score1Spawn()
		score1Spawn()
		score1Spawn()
		score5Spawn()
		score5Spawn()
		score5Spawn()
		score25Spawn()
		score25Spawn()
		score25Spawn()

var scoreStar1=preload("res://scenes/1ScoreStar.tscn")
var scoreStar5=preload("res://scenes/5ScoreStar.tscn")
var scoreStar25=preload("res://scenes/25ScoreStar.tscn")
@onready var scoreStarsHolder: Node2D = $ScoreStars
@onready var mainSoftBody: Node2D = $"../mainSoftBody"

func score1Spawn():
	var DecisiveNumber=rng.randi_range(0,3000)
	if DecisiveNumber<=clamp((global.score),0,2000):
		var scoreStar1Instance=scoreStar1.instantiate()
		scoreStar1Instance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-560,560),randf_range(1000,3000))
		scoreStarsHolder.add_child(scoreStar1Instance)

func score5Spawn():
	var DecisiveNumber=rng.randi_range(0,3000)
	if DecisiveNumber<=clamp((global.score-2000)/3,0,2000):
		var scoreStar5Instance=scoreStar5.instantiate()
		scoreStar5Instance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-560,560),randf_range(1000,3000))
		scoreStarsHolder.add_child(scoreStar5Instance)

func score25Spawn():
	var DecisiveNumber=rng.randi_range(0,3000)
	if DecisiveNumber<=clamp((global.score-5000)/7,0,2000):
		var scoreStar25Instance=scoreStar25.instantiate()
		scoreStar25Instance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-560,560),randf_range(1000,3000))
		scoreStarsHolder.add_child(scoreStar25Instance)
