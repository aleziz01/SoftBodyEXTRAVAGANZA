extends Node

var gameOver=false
var score:int=0
var maxScore:int=0
var paused:bool=false

func _process(_delta: float) -> void:
	maxScore=max(score,maxScore)
