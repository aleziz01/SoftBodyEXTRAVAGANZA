extends TextureProgressBar

func _on_timer_timeout() -> void:
	value+=1

func _process(_delta: float) -> void:
	if value==max_value and visible:
		hide()