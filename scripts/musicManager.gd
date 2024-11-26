extends AudioStreamPlayer

var OST1=preload("res://music/OST1.mp3")
var OST2=preload("res://music/OST2.mp3")
@onready var whatSong: RichTextLabel = $"../Hud/WhatSong"

var rng=RandomNumberGenerator.new()
var pastNumb=1
func _ready() -> void:
	showNewSong()

func _on_finished() -> void:
	var randNumb=rng.randi_range(1,2)
	while(randNumb==pastNumb):
		randNumb=rng.randi_range(1,2)
	if randNumb==1:
		stream=OST1
	elif randNumb==2:
		stream=OST2
	pastNumb=randNumb
	showNewSong()
	await get_tree().create_timer(3).timeout
	play()

func showNewSong():
	whatSong.text="SONG: OST" + str(pastNumb) #pastNumb=realNumb at this point
	while(whatSong.position.x<=-630):
		whatSong.position.x+=0.5*int(!global.paused)
		await get_tree().create_timer(0.01).timeout
	await get_tree().create_timer(2).timeout
	while(whatSong.position.x>-850):
		whatSong.position.x-=0.5*int(!global.paused)
		await get_tree().create_timer(0.01).timeout
