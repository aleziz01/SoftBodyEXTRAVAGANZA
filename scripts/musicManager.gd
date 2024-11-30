extends AudioStreamPlayer

var OST1=preload("res://music/OST1.mp3")
var OST2=preload("res://music/OST2.mp3")
var OST3=preload("res://music/OST3.mp3")
@onready var whatSong: RichTextLabel = $"../Hud/WhatSong"

var rng=RandomNumberGenerator.new()
var pastNumb=1

func _on_finished() -> void:
	var randNumb=rng.randi_range(1,3)
	while(randNumb==pastNumb):
		randNumb=rng.randi_range(1,3)
	if randNumb==1:
		stream=OST1
		volume_db=0
	elif randNumb==2:
		stream=OST2
		volume_db=0
	elif randNumb==3:
		stream=OST3
		volume_db=-2
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

var playButtonPressed=false
func _on_play_button_pressed() -> void:
	if !playButtonPressed:
		playButtonPressed=true
		_on_finished()
		showNewSong()
