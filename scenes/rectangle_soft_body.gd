extends Node2D


func _ready() -> void:
	unload()

@onready var mainSoftBody: Node2D = $"../../mainSoftBody"
var triedToKill=false

func unload():
	while(true):
		await get_tree().create_timer(0.1).timeout
		if(global.gameOver and global_position.y+500<mainSoftBody.realPos):
			queue_free()
		if(!global.gameOver and !triedToKill and global_position.y-2000>mainSoftBody.realPos):
			queue_free()
