extends Area2D

func _ready() -> void:
	unload()
	
@onready var mainSoftBody: Node2D = $"../../../mainSoftBody"

func unload():
	while(true):
		await get_tree().create_timer(0.1).timeout
		if(global.gameOver and global_position.y+500<mainSoftBody.realPos):
			queue_free()
