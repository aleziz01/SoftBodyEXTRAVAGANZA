extends Node2D

@onready var mainSoftBody: Node2D = $"../mainSoftBody"
var BlackHole=preload("res://scenes/BlackHoleCool.tscn")
var Block=preload("res://scenes/rectangleSoftBody.tscn")

func _ready() -> void:
	run()

var rng=RandomNumberGenerator.new()
func run() -> void:
	while(true):
		await get_tree().create_timer(0.1).timeout
		BlackHoleSpawn()
		BlockSpawn()


@onready var BlackHoleContainer: Node2D = $BlackHoles
@onready var BlockHolder: Node2D = $BlockHolder

func BlackHoleSpawn():
	#Black Hole Spawning
	var DecisiveNumber=rng.randi_range(0,2000)
	if DecisiveNumber<=clamp((global.score-3000)/100,0,2000):
		var BlackHoleInstance=BlackHole.instantiate()
		BlackHoleInstance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-540,540),randf_range(2000,4000))
		BlackHoleContainer.add_child(BlackHoleInstance)

func BlockSpawn():
	#Falling Block Spawning
	var DecisiveNumber=rng.randi_range(0,2000)
	if DecisiveNumber<=clamp((global.score)/100,0,2000):
		var BlockInstance=Block.instantiate()
		BlockInstance.global_position=Vector2(0,mainSoftBody.realPos)-Vector2(randf_range(-540,540),randf_range(1500,3000))
		BlockHolder.add_child(BlockInstance)
