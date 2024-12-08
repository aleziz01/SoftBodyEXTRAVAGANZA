extends Node2D

@onready var skeleton=get_child(0).get_child(0)
@onready var softBody=get_child(0)
var realPos
var realPosx

func _ready() -> void:
	CalculatePos()

func _process(_delta: float) -> void:
	CalculatePos()


func CalculatePos():
	var tempPos=0
	var tempPosx=0
	for i in skeleton.get_children():
		tempPos+=i.global_position.y
		tempPosx+=i.global_position.x
	realPos=tempPos/skeleton.get_child_count()
	realPosx=tempPosx/skeleton.get_child_count()
	global.score=-1*(realPos)/20+13
