extends Node2D

var wall=preload("res://scenes/softwall.tscn")

@onready var mainSoftBody: Node2D = $"../../../mainSoftBody"

var spawnedwall=false
var rng=RandomNumberGenerator.new()
func _physics_process(delta: float) -> void:
	if(mainSoftBody.realPos-700<global_position.y and !spawnedwall):
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

func _process(delta: float) -> void:
	if global_position.y-800>mainSoftBody.realPos:
		queue_free()
