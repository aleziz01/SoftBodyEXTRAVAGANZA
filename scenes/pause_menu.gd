extends Node2D

func _ready() -> void:
	checkForPause()

func checkForPause():
	while(true):
		await get_tree().create_timer(0.001).timeout
		if Input.is_action_just_pressed("pause"):
			global.paused=!global.paused
			get_tree().paused=global.paused
			updateBG()

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
		print("modulated")
	else:
		fading=true
		while(self.modulate.a>0.0 and fading):
			self.modulate.a-=0.01
			await get_tree().create_timer(0.001).timeout
		fading=false
		self.modulate.a=0.0
		print("modulated")
