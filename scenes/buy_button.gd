extends TextureButton

@export var price=10
@export var upgradeIndex=0
@export var exponentiationNumber=2

@onready var priceLabel: RichTextLabel = $Price
@onready var shop_tab: Node2D = $".."


func _ready() -> void:
	await get_tree().create_timer(0.01).timeout
	connect("pressed",_on_button_pressed)
	for i in global.Upgrades[upgradeIndex]:
		price*=4
		print("increased")
	priceLabel.text=str(price)
	print(price)

func _process(delta: float) -> void:
	checkPrice()

func _on_button_pressed():
	global.starScore-=price
	global.Upgrades[upgradeIndex]+=1
	price*=exponentiationNumber
	priceLabel.text=str(price)

func checkPrice():
	if(global.starScore<price):
		disabled=true
	else:
		disabled=!(shop_tab.shopOpened==true) #sexy ass code
 
