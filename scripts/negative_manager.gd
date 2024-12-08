extends Node2D

@onready var mainSoftBody: Node2D = $"../mainSoftBody"
var BlackHole=preload("res://scenes/BlackHoleCool.tscn")
var Block=preload("res://scenes/rectangleSoftBody.tscn")
var Cannon=preload("res://scenes/cannon.tscn")

func _ready() -> void:
	run()

var rng=RandomNumberGenerator.new()
func run() -> void:
	while(true):
		await get_tree().create_timer(0.1).timeout
		#have separate spawn functions for all negative objects.
		if(global.paused==false and !global.gameOver and global.gameStarted):
			if global.score<20000:
				BlockSpawn()
			if global.score>20000:
				HarderBlockSpawn()
			if global.score<30000:
				BlackHoleSpawn()
				CannonSpawn()
			if global.score>30000:
				BiggerBlackHoleSpawn()
				HarderCannonSpawn()


@onready var BlackHoleContainer: Node2D = $BlackHoles
@onready var BlockHolder: Node2D = $BlockHolder
@onready var CannonHolder: Node2D = $CannonHolder

func HarderBlockSpawn():
	pass

func BiggerBlackHoleSpawn():
	pass

func HarderCannonSpawn():
	pass

func BlackHoleSpawn():
	#Black Hole Spawning
	var DecisiveNumber=rng.randi_range(0,3000)
	if DecisiveNumber<clamp((global.score-5000)/100,0,2000):
		var BlackHoleInstance=BlackHole.instantiate()
		BlackHoleInstance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-540,540),randf_range(2000,4000))
		BlackHoleInstance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		BlackHoleContainer.add_child(BlackHoleInstance)

func BlockSpawn():
	#Falling Block Spawning
	var DecisiveNumber=rng.randi_range(0,2000)
	if DecisiveNumber<=clamp((global.score)/100,0,2000):
		var BlockInstance=Block.instantiate()
		BlockInstance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-540,540),randf_range(1500,3000))
		BlockInstance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		BlockHolder.add_child(BlockInstance)

func CannonSpawn():
	var DecisiveNumber=rng.randi_range(0,4000)
	if DecisiveNumber<clamp((global.score-3000)/100,0,2000):
		var CannonInstance=Cannon.instantiate()
		var sign=sign(randi_range(-101,100))
		CannonInstance.scale.x=sign
		CannonInstance.global_position=Vector2(575*sign,mainSoftBody.realPos)-Vector2(0,randf_range(2000,4000))
		CannonInstance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		CannonHolder.add_child(CannonInstance)
