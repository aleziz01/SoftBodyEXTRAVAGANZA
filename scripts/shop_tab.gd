extends Node2D

@onready var main_menu: Node2D = $"../MainMenu"
@onready var shop_sprite: AnimatedSprite2D = $ShopSprite

#buttons to show and enable
@onready var control_info_button: TextureButton = $"../MainMenu/VBoxContainer/controlInfoButton"
@onready var play_button: TextureButton = $"../MainMenu/VBoxContainer/PlayButton"
@onready var exit_button: TextureButton = $"../MainMenu/VBoxContainer/ExitButton"
@onready var shop_button: TextureButton = $"../MainMenu/VBoxContainer/shopButton"
@onready var continue_button: TextureButton = $"../MainMenu/VBoxContainer/ContinueButton"

#buttons to hide and disable
@onready var back_button: TextureButton = $BackButton

var shopOpened=false
func _on_back_button_pressed() -> void:
	global.switchFades(main_menu,self)
	playShopAnimationBack()
	for i in get_children():
		if i is TextureButton:
			i.disabled=true
	await get_tree().create_timer(1.2).timeout
	control_info_button.disabled=false
	exit_button.disabled=false
	play_button.disabled=false
	continue_button.disabled=false
	shop_button.disabled=false

func playShopAnimationBack():
	shop_sprite.frame=17
	shop_sprite.play("default")
	shop_sprite.speed_scale=-1
	while(shop_sprite.frame>=12): #code looks kinda bad here, can change later if u want
		if shop_sprite.frame<=14:
			for i in get_children():
				if i!=get_child(0) and i is TextureButton and i.position.y>=-150:
					i.hide()
		await get_tree().create_timer(0.01).timeout
	for i in get_children():
		if i!=get_child(0) and i is TextureButton:
			i.hide()

func _ready() -> void:
	checkPrices()

func checkPrices():
	for i in get_children():
		if i!=get_child(0) and i!=get_child(get_child_count()-1)and i is TextureButton:
			i.checkPrice()

@onready var starScoreShowerShop: RichTextLabel = $StarCounter

func _process(delta: float) -> void:
	starScoreShowerShop.text="STARS: "+str(global.starScore)
