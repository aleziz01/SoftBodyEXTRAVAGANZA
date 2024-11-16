extends Node2D

var explosion=preload("res://scenes/explosion.tscn")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("explode"):
		var explosionInstance=explosion.instantiate()
		explosionInstance.global_position=get_global_mouse_position()
		add_child(explosionInstance)
