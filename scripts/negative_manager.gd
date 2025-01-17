extends Node2D

@onready var mainSoftBody: Node2D = $"../mainSoftBody"
var BlackHole=preload("res://scenes/BlackHoleCool.tscn")
var Block=preload("res://scenes/TreeSoftBody.tscn")
var Cannon=preload("res://scenes/cannon.tscn")
var HarderBlock=preload("res://scenes/harder_block_body.tscn")
var BiggerBlackHole=preload("res://scenes/BiggerBlackHole.tscn")

@onready var BlackHoleContainer: Node2D = $BlackHoles
@onready var BlockHolder: Node2D = $BlockHolder
@onready var CannonHolder: Node2D = $CannonHolder
@onready var HarderBlockHolder: Node2D = $"../Hud/HarderBlockHolder"
@onready var BiggerBlackHoleContainer: Node2D = $BiggerBlackHoles

func _ready() -> void:
	run()

var rng=RandomNumberGenerator.new()
func run() -> void:
	while(true):
		await get_tree().create_timer(0.1).timeout
		#have separate spawn functions for all negative objects.
		if(global.paused==false and !global.gameOver and global.gameStarted):
			if global.score<20000:
				EnemySpawn(Block,(global.score)/(100+global.Upgrades[6]*25),rng.randi_range(0,2000+global.Upgrades[6]*500),BlockHolder) #FALLING BLOCK SPAWNER
			if global.score<30000:
				EnemySpawn(BlackHole,(global.score-5000)/(100+global.Upgrades[6]*25),rng.randi_range(0,3000+global.Upgrades[6]*500),BlackHoleContainer)
				CannonSpawn() #THIS NEEDS A VERY SPECIFIC SPAWN
			if global.score>20000:
				EnemySpawn(HarderBlock,(global.score)/(500+global.Upgrades[6]*25),rng.randi_range(0,5000+global.Upgrades[6])*500,HarderBlockHolder)
				EnemySpawn(HarderBlock,(global.score)/(500+global.Upgrades[6]*25),rng.randi_range(0,5000+global.Upgrades[6])*500,HarderBlockHolder)
			if global.score>30000:
				EnemySpawn(BiggerBlackHole,(global.score-10000)/(600+global.Upgrades[6]*25),rng.randi_range(0,5000+global.Upgrades[6]*500),BiggerBlackHoleContainer)
				HarderCannonSpawn() #THIS NEEDS A VERY SPECIFIC SPAWN
				HarderCannonSpawn() #THIS NEEDS A VERY SPECIFIC SPAWN

func EnemySpawn(thingToSpawn,condition,DecisiveNumber,Holder):
	if DecisiveNumber<clamp(condition,0,2000):
		var thingInstance=thingToSpawn.instantiate()
		thingInstance.global_position=Vector2(0,mainSoftBody.realPos.y)-Vector2(randf_range(-540,540),randf_range(1500,4000))
		thingInstance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		Holder.add_child(thingInstance)

func HarderCannonSpawn():
	pass

func CannonSpawn():
	var DecisiveNumber=rng.randi_range(0,4000+global.Upgrades[6]*500)
	if DecisiveNumber<clamp((global.score-3000)/(100+25*global.Upgrades[6]),0,2000):
		var CannonInstance=Cannon.instantiate()
		var sign=sign(randi_range(-101,100))
		CannonInstance.scale.x=sign
		CannonInstance.global_position=Vector2(575*sign,mainSoftBody.realPos.y)-Vector2(0,randf_range(2000,4000))
		CannonInstance.mainSoftBody=mainSoftBody #VERY IMPORTANT
		CannonHolder.add_child(CannonInstance)
