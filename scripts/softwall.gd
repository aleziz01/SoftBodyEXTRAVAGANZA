extends Node2D

var wall=preload("res://scenes/softwall.tscn")

@onready var mainSoftBody: Node2D = $"../../mainSoftBody"

var spawnedwall=false
var postSpawnedwall=false
var rng=RandomNumberGenerator.new()
var isMinimum=false
func _physics_process(_delta: float) -> void:
	if(mainSoftBody.realPos.y-700<global_position.y and !spawnedwall and !global.gameOver):
		spawnedwall=true
		var wallInstance=wall.instantiate()
		wallInstance.global_position=global_position-Vector2(0,600)
		wallInstance.get_child(0).scale=get_child(0).scale
		wallInstance.get_child(0).position=get_child(0).position
		wallInstance.get_child(1).scale=get_child(1).scale
		wallInstance.get_child(1).position=get_child(1).position
		wallInstance.get_child(2).constant_force=get_child(2).constant_force
		wallInstance.modulate.r=rng.randf_range(0,1)
		wallInstance.modulate.g=rng.randf_range(0,1)
		wallInstance.modulate.b=rng.randf_range(0,1)
		get_parent().add_child.call_deferred(wallInstance)
	if global.gameOver:
		AmI_Minimum()
	if global.gameOver and !postSpawnedwall and mainSoftBody.realPos.y+700>global_position.y and isMinimum and global_position.y+400<0:
		postSpawnedwall=true
		var wallInstance=wall.instantiate()
		wallInstance.global_position=global_position+Vector2(0,600)
		wallInstance.get_child(0).scale=get_child(0).scale
		wallInstance.get_child(0).position=get_child(0).position
		wallInstance.get_child(1).scale=get_child(1).scale
		wallInstance.get_child(1).position=get_child(1).position
		wallInstance.get_child(2).constant_force=get_child(2).constant_force
		wallInstance.get_child(2).gravity_scale=1
		wallInstance.modulate.r=rng.randf_range(0,1)
		wallInstance.modulate.g=rng.randf_range(0,1)
		wallInstance.modulate.b=rng.randf_range(0,1)
		get_parent().add_child.call_deferred(wallInstance)

func AmI_Minimum():
	var maximum=global_position.y-1
	for i in get_tree().get_nodes_in_group("wall"):
		maximum=max(maximum,i.global_position.y)
	if maximum==global_position.y:
		isMinimum=true
	
var DEATH=false
func _process(_delta: float) -> void:
	if global_position.y-800>mainSoftBody.realPos.y and !global.gameOver:
		queue_free()
	elif global.gameOver and global_position.y+800<mainSoftBody.realPos.y:
		queue_free()
