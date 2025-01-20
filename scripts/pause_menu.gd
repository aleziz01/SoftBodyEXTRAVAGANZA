extends Node2D

func _ready() -> void:
	checkForPause()

func checkForPause():
	while(true):
		await get_tree().create_timer(0.001).timeout
		if Input.is_action_just_pressed("pause") and global.gameStarted:
			global.paused=!global.paused
			get_tree().paused=global.paused
			updateBG()
			await get_tree().create_timer(1).timeout
			for i in $VBoxContainer.get_children():
				i.disabled=!global.paused

var fading=false

func updateBG():
	fading=false
	await get_tree().create_timer(0.001).timeout
	if global.paused:
		fading=true
		while(self.modulate.a<=1.0 and fading):
			self.modulate.a+=0.01
			await get_tree().create_timer(0.001).timeout
		fading=false
		self.modulate.a=1.0
	else:
		fading=true
		while(self.modulate.a>0.0 and fading):
			self.modulate.a-=0.01
			await get_tree().create_timer(0.001).timeout
		fading=false
		self.modulate.a=0.0

func _on_quit_pressed() -> void:
	global.saveGame()
	await get_tree().create_timer(0.005).timeout
	get_tree().quit()

func _on_retry_pressed() -> void:
	get_tree().paused=false
	global.paused=false
	global.saveGame()
	await get_tree().create_timer(0.005).timeout
	get_tree().change_scene_to_file("res://scenes/load_screen.tscn")
