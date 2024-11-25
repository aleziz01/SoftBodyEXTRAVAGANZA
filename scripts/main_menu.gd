extends Node2D

@onready var main_menu: Node2D = $CanvasLayer/MainMenu
@onready var control_info: Node2D = $CanvasLayer/ControlInfo
@onready var bg: Polygon2D = $bg

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_play_button_pressed() -> void:
	global.gameStarted=true
	global.fadeOut(main_menu)
	global.fadeOut(control_info)
	global.fadeOut(self)
	await get_tree().create_timer(1).timeout
	global.fadeIn($"../Hud")
	await get_tree().create_timer(1).timeout
	queue_free()

func _on_control_info_button_pressed() -> void:
	global.switchFades(control_info,main_menu)
