extends Polygon2D
var bg = preload("res://scenes/BG.tscn")
@onready var mainSoftBody: Node2D = $"../mainSoftBody"
var spawnedBG=false
func _physics_process(delta: float) -> void:
	if(mainSoftBody.realPos-700<global_position.y and !spawnedBG):
		spawnedBG=true
		var bgInstance=bg.instantiate()
		bgInstance.global_position=global_position-Vector2(0,600)
		get_parent().add_child.call_deferred(bgInstance)
