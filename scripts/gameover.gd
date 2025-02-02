extends Sprite2D

@onready var buttonPress: AudioStreamPlayer = $"../../AudioStreamPlayer"

func _on_quit_pressed() -> void:
	buttonPress.play()
	global.saveGame()
	await get_tree().create_timer(0.005).timeout
	get_tree().quit()

func _on_retry_pressed() -> void:
	buttonPress.play()
	global.saveGame()
	await get_tree().create_timer(0.005).timeout
	get_tree().change_scene_to_file("res://scenes/load_screen.tscn")

func gameover():
	global.starScore+=global.maxScore/10
	updateLabels()
	global.fadeIn(self)
	await get_tree().create_timer(1).timeout
	for i in $VBoxContainer.get_children():
		if i is TextureButton:
			i.disabled=false

@onready var run_score: RichTextLabel = $VBoxContainer2/RunScore
@onready var high_score: RichTextLabel = $VBoxContainer2/HighScore
@onready var your_time: RichTextLabel = $VBoxContainer2/YourTime
@onready var best_time: RichTextLabel = $VBoxContainer2/BestTime
@onready var bonus_stars: RichTextLabel = $VBoxContainer2/BonusStars

func updateLabels():
	run_score.text="SCORE: " + str(global.maxScore)
	high_score.text="HIGH SCORE: " + str(global.HighScore)
	your_time.text="TIME: " + str(global.time[0]) + "H " + str(global.time[1]) + "M " + str(global.time[2]) + "S"
	best_time.text="BEST TIME: " + str(global.BestTime[0]) + "H " + str(global.BestTime[1]) + "M " + str(global.BestTime[2]) + "S"
	bonus_stars.text="BONUS STARS: " + str(global.maxScore/10)
