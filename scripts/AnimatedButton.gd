extends AnimatedSprite2D

func _ready() -> void:
	connect("animation_finished",_on_animation_finished)
	get_child(0).connect("pressed",_on_button_pressed)
	get_child(0).connect("button_down",_on_button_down)

func _on_button_down():
	hide()

func _on_button_pressed() -> void:
	show()
	get_child(0).hide()
	frame=1
	play("pressed")

func _on_animation_finished() -> void:
	get_child(0).show()
