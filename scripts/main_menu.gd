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
	for i in get_children():
		if i is TextureButton:
			i.disabled=true
	$CanvasLayer/PointLight2D.queue_free()
	global.saveGame()
	global.starScore=0
	global.HighScore=0
	global.maxScore=0
	global.winningDistance=50
	global.initialStarScore=0
	global.winningDistance=50
	global.wins=0
	global.Upgrades=[0,0,0,0,0,0,0,0,0,0]
	global.selfDestructHP=0
	global.secondLives=0
	global.fadeOut(main_menu)
	global.fadeOut(control_info)
	global.fadeOut(self)
	await get_tree().create_timer(1).timeout
	global.gameStarted=true
	global.fadeIn($"../Hud")
	await get_tree().create_timer(4).timeout
	queue_free()


func _on_continue_button_pressed() -> void:
	control_info_button.disabled=true
	play_button.disabled=true
	exit_button.disabled=true
	shop_button.disabled=true
	continue_button.disabled=true
	$CanvasLayer/PointLight2D.queue_free()
	global.fadeOut(main_menu)
	global.fadeOut(control_info)
	global.fadeOut(self)
	await get_tree().create_timer(1).timeout
	global.fadeIn($"../Hud")
	global.gameStarted=true
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

@onready var shop_sprite: AnimatedSprite2D = $CanvasLayer/ShopTab/ShopSprite


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
	shop_tab.shopOpened=true
	playShopAnimationForward()

func playShopAnimationForward():
	shop_sprite.frame=0
	shop_sprite.play("default")
	shop_sprite.speed_scale=1
	while(shop_sprite.frame<=14): #code looks kinda bad here, can change later if u want
		if shop_sprite.frame>=12:
			for i in shop_tab.get_children():
				if i!=shop_tab.get_child(0) and i is TextureButton and i.position.y<=-150:
					i.show()
		await get_tree().create_timer(0.01).timeout
	for i in shop_tab.get_children():
		if i!=shop_tab.get_child(0) and i is TextureButton:
			i.show()
