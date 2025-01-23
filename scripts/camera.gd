extends Camera2D

@onready var softBody: Node2D = $"../mainSoftBody"

func _process(_delta: float) -> void:
	if !global.gameOver and global.score<global.winningDistance:
		global_position.y=min(softBody.realPos.y,global_position.y)
	elif !global.gameWon:
		global_position.y=softBody.realPos.y
