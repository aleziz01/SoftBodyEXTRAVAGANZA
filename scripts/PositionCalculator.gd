extends Node2D

@onready var skeleton=get_child(0).get_child(0)
@onready var softBody=get_child(0)
var realPos:Vector2=Vector2(0,0)

func _ready() -> void:
	CalculatePos()

func _process(_delta: float) -> void:
	CalculatePos()

func CalculatePos():
	var tempPos=Vector2(0,0)
	for i in skeleton.get_children():
		tempPos+=Vector2(i.global_position.x,i.global_position.y)
	realPos=Vector2(tempPos.x/skeleton.get_child_count(),tempPos.y/skeleton.get_child_count())
	global.score=-1*(realPos.y)/20+13