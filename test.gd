extends Node2D

var explosion=preload("res://scenes/explosion.tscn")

func _input(_event: InputEvent) -> void:
	if (Input.is_action_just_pressed("explode")):
		var explosionInstance=explosion.instantiate()
		explosionInstance.global_position=get_global_mouse_position()
		add_child(explosionInstance)

func _ready() -> void:
	$Node2D/Node2D2/Cannon.mainSoftBody=$MainSoftBody
