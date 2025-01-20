extends Node2D

@export var parent:TextureButton

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	parent.disconnect("pressed",parent._on_button_pressed)

func _on_button_pressed():
	global.starScore-=parent.price
	for i in 10:
		var buyButtonAccessed=parent.get_parent().get_node("BuyButton" + str(i+1))
		while(global.Upgrades[i]):
			global.Upgrades[i]-=1
			buyButtonAccessed.price/=buyButtonAccessed.exponentiationNumber
			global.starScore+=buyButtonAccessed.price
	parent.price*=parent.exponentiationNumber
	parent.priceLabel.text=str(parent.price)
	global.saveGame()
