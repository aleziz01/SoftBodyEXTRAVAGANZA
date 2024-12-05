extends Node2D

@onready var main_menu: Node2D = $"../MainMenu"

#buttons to show and enable
@onready var control_info_button: TextureButton = $"../MainMenu/VBoxContainer/controlInfoButton"
@onready var play_button: TextureButton = $"../MainMenu/VBoxContainer/PlayButton"
@onready var exit_button: TextureButton = $"../MainMenu/VBoxContainer/ExitButton"
@onready var shop_button: TextureButton = $"../MainMenu/VBoxContainer/shopButton"
@onready var continue_button: TextureButton = $"../MainMenu/VBoxContainer/ContinueButton"

#buttons to hide and disable
@onready var back_button: TextureButton = $BackButton

func _on_back_button_pressed() -> void:
	global.switchFades(main_menu,self)
	for i in get_children():
		if i is TextureButton:
			i.disabled=true
	await get_tree().create_timer(1.2).timeout
	control_info_button.disabled=false
	exit_button.disabled=false
	play_button.disabled=false
	continue_button.disabled=false
	shop_button.disabled=false

func _ready() -> void:
	for i in get_children(0):
		if i!=get_child(0):
			i.connect("pressed",checkPrices)

func checkPrices():
	for i in get_children():
		if i!=get_child(0):
			i.checkPrice()
