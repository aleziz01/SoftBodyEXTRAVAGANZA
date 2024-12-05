extends TextureButton

@export var price=10
@export var upgradeIndex=0

func _ready() -> void:
	await get_tree().create_timer(0.01).timeout
	connect("pressed",_on_button_pressed)
	for i in global.Upgrades[upgradeIndex]:
		price*=4
		print("increased")
	checkPrice()

func _on_button_pressed():
	global.starScore-=price
	global.Upgrades[upgradeIndex]+=1
	price*=4

func checkPrice():
	print(price)
	if(global.starScore<price):
		disabled=true
