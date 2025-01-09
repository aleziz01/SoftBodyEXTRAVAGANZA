extends Polygon2D
var bg = preload("res://scenes/BG.tscn")
@onready var mainSoftBody: Node2D = $"../../mainSoftBody"
var spawnedBG=false
var rng=RandomNumberGenerator.new()

func _physics_process(_delta: float) -> void:
	if(mainSoftBody.realPos.y-700<global_position.y and !spawnedBG):
		spawnedBG=true
		var bgInstance=bg.instantiate()
		bgInstance.global_position=global_position-Vector2(0,600)
		bgInstance.modulate.r=rng.randf_range(0.9-float(global.score)/10000.0,1-float(global.score)/10000.0)
		bgInstance.modulate.g=rng.randf_range(0.9-float(global.score)/10000.0,1-float(global.score)/10000.0)
		bgInstance.modulate.b=rng.randf_range(0.9-float(global.score)/10000.0,1-float(global.score)/10000.0)
		get_parent().add_child.call_deferred(bgInstance)
