extends Node2D

@onready var main_menu: Node2D = $CanvasLayer/MainMenu
@onready var control_info: Node2D = $CanvasLayer/ControlInfo
@onready var bg: Polygon2D = $bg
@onready var shop_tab: Node2D = $CanvasLayer/ShopTab

func _enter_tree() -> void:
	if global.gameStarted:
		_on_continue_button_pressed()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

@onready var container: Sprite2D = $CanvasLayer/MainMenu/Container
@onready var yes_button: TextureButton = $CanvasLayer/MainMenu/Container/YesButton
@onready var no_button: TextureButton = $CanvasLayer/MainMenu/Container/NoButton

func _on_new_game_button_pressed() -> void:
	container.show()
	no_button.disabled=false
	yes_button.disabled=false

func hideContainer():
	no_button.disabled=true
	yes_button.disabled=true
	container.hide()

func _on_no_button_pressed() -> void:
	hideContainer()

func _on_yes_button_pressed() -> void:
	hideContainer()
	control_info_button.disabled=true
	play_button.disabled=true
	exit_button.disabled=true
	shop_button.disabled=true
	continue_button.disabled=true
	$CanvasLayer/PointLight2D.queue_free()
	global.saveGame()
	global.gameStarted=true
	global.fadeOut(main_menu)
	global.fadeOut(control_info)
	global.fadeOut(self)
	await get_tree().create_timer(1).timeout
	global.fadeIn($"../Hud")
	await get_tree().create_timer(1).timeout
	queue_free()


func _on_continue_button_pressed() -> void:
	control_info_button.disabled=true
	play_button.disabled=true
	exit_button.disabled=true
	shop_button.disabled=true
	continue_button.disabled=true
	global.loadGame()
	$CanvasLayer/PointLight2D.queue_free()
	global.gameStarted=true
	global.fadeOut(main_menu)
	global.fadeOut(control_info)
	global.fadeOut(self)
	await get_tree().create_timer(1).timeout
	global.fadeIn($"../Hud")
	await get_tree().create_timer(4).timeout
	queue_free()


#buttons to show and enable
#controlTab
@onready var control_back_button: TextureButton = $CanvasLayer/ControlInfo/BackButton
#shopTab
@onready var shop_back_button: TextureButton = $CanvasLayer/ShopTab/BackButton

#buttons to hide and disable
@onready var control_info_button: TextureButton = $CanvasLayer/MainMenu/VBoxContainer/controlInfoButton
@onready var play_button: TextureButton = $CanvasLayer/MainMenu/VBoxContainer/PlayButton
@onready var exit_button: TextureButton = $CanvasLayer/MainMenu/VBoxContainer/ExitButton
@onready var shop_button: TextureButton = $CanvasLayer/MainMenu/VBoxContainer/shopButton
@onready var continue_button: TextureButton = $CanvasLayer/MainMenu/VBoxContainer/ContinueButton

func _on_control_info_button_pressed() -> void:
	global.switchFades(control_info,main_menu)
	control_info_button.disabled=true
	play_button.disabled=true
	exit_button.disabled=true
	shop_button.disabled=true
	continue_button.disabled=true
	await get_tree().create_timer(1.2).timeout
	control_back_button.disabled=false

func _on_shop_button_pressed() -> void:
	global.switchFades(shop_tab,main_menu)
	control_info_button.disabled=true
	play_button.disabled=true
	exit_button.disabled=true
	shop_button.disabled=true
	continue_button.disabled=true
	await get_tree().create_timer(1.2).timeout
	shop_back_button.disabled=false
