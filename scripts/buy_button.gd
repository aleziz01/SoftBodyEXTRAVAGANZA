extends TextureButton

@export var price=10
@export var upgradeIndex=0
@export var exponentiationNumber=4

@onready var priceLabel: RichTextLabel = $Price
@onready var shop_tab: Node2D = $".."
@onready var shop_shader: Sprite2D = $ShopShader
@export var cap=10

func _ready() -> void:
	hide()
	await get_tree().create_timer(0.01).timeout
	connect("pressed",_on_button_pressed)
	for i in global.Upgrades[upgradeIndex]:
		price*=exponentiationNumber
	priceLabel.text=str(price)

func _process(_delta: float) -> void:
	checkPrice()

func _on_button_pressed():
	global.starScore-=price
	global.Upgrades[upgradeIndex]+=1
	price*=exponentiationNumber
	global.saveGame()

func checkPrice():
	if(global.Upgrades[upgradeIndex]>cap):
		for i in global.Upgrades[upgradeIndex]-cap:
			global.starScore+=price
			price/=exponentiationNumber
		global.Upgrades[upgradeIndex]=cap
	if(global.starScore<price or global.Upgrades[upgradeIndex]==cap):
		disabled=true
	else:
		disabled=!(shop_tab.shopOpened==true) #sexy ass code
	shop_shader.visible=disabled
	priceLabel.text=str(price)
