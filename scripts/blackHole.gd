extends Area2D

@export var ScoreStar:Area2D
@export var limit=Vector2(1,1)
func _ready() -> void:
	print("spawned")
	var scaler=clamp(randf_range(1.4,1.8),limit.x,limit.y)
	scale=Vector2(scaler,scaler)
	ScoreStar.mainSoftBody=mainSoftBody
	unload()

@onready var mainSoftBody: Node2D = $"../../../mainSoftBody"

func unload():
	while(true):
		await get_tree().create_timer(0.1).timeout
		if(global.gameOver and global_position.y+500<mainSoftBody.realPos):
			queue_free()
		if(!global.gameOver and global_position.y-2000>mainSoftBody.realPos):
			queue_free()
