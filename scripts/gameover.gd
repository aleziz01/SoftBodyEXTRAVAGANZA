extends Sprite2D

func _on_quit_pressed() -> void:
	global.saveGame()
	await get_tree().create_timer(0.005).timeout
	get_tree().quit()

func _on_retry_pressed() -> void:
	global.saveGame()
	await get_tree().create_timer(0.005).timeout
	get_tree().change_scene_to_file("res://scenes/load_screen.tscn")

func gameover():
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

func updateLabels():
	run_score.text="SCORE: " + str(global.maxScore)
	high_score.text="HIGH SCORE: " + str(global.HighScore)
	your_time.text="TIME: " + str(global.time[0]) + "H " + str(global.time[1]) + "M " + str(global.time[2]) + "S"
