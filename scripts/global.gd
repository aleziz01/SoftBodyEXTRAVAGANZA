extends Node

var gameStarted:bool=false
var gameOver=false
var score:int=0
var maxScore:int=0
var starScore:int=0
var paused:bool=false

func _process(_delta: float) -> void:
	maxScore=max(score,maxScore)

func switchFades(node1,node2):
	fadeIn(node1)
	fadeOut(node2)

func fadeOut(node):
	while(node.modulate.a>0.0):
		node.modulate.a-=0.01
		await get_tree().create_timer(0.01).timeout

func fadeIn(node):
	while(node.modulate.a<=1.0):
		node.modulate.a+=0.01
		await get_tree().create_timer(0.01).timeout
