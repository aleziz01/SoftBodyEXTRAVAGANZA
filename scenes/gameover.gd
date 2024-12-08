extends Sprite2D

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_retry_pressed() -> void:
	global.saveGame()
	await get_tree().create_timer(0.005).timeout
	get_tree().change_scene_to_file("res://scenes/load_screen.tscn")
