extends Camera2D

@onready var softBody: Node2D = $"../mainSoftBody"

func _process(delta: float) -> void:
	global_position.y=min(softBody.realPos,global_position.y)
