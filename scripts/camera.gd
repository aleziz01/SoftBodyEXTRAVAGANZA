extends Camera2D

@onready var softBody: Node2D = $"../mainSoftBody"

func _process(_delta: float) -> void:
	if !global.gameOver:
		global_position.y=min(softBody.realPos,global_position.y)
	else:
		global_position.y=softBody.realPos
