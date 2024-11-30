extends AnimatedSprite2D

func _ready() -> void:
	connect("animation_finished",_on_animation_finished)
	get_child(0).connect("pressed",_on_button_pressed)

func _on_button_pressed() -> void:
	get_child(0).hide()
	play("pressed")

func _on_animation_finished() -> void:
	get_child(0).show()
