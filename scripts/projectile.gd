extends Node2D

var mainSoftBody: Node2D

func unload():
	while(true):
		await get_tree().create_timer(0.1).timeout
		if(global.gameOver and global_position.y+700<mainSoftBody.realPos.y):
			queue_free()
		if(mainSoftBody and !global.gameOver and global_position.y-2000>mainSoftBody.realPos.y):
			queue_free()
