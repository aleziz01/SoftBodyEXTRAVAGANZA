extends Node2D

var mainSoftBody: Node2D
var dead=false

func _ready() -> void:
	unload()

func unload():
	while(true and !dead):
		await get_tree().create_timer(0.1).timeout
		if(global.gameOver and global_position.y+700<mainSoftBody.realPos.y):
			queue_free()
		if(mainSoftBody and !global.gameOver and global_position.y-2000>mainSoftBody.realPos.y):
			queue_free()
