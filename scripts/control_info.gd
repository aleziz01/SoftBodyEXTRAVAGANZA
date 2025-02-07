extends Node2D

@onready var cursor_sprite: Sprite2D = $CursorSprite
var speed=0

var explosion = preload("res://scenes/explosion.tscn")

func _ready() -> void:
	Float()

func Float():
	while(true):
		while(cursor_sprite.position.y>=-100):#accelerate up
			speed-=0.6
			await get_tree().create_timer(0.01).timeout
		explodeCursor()
		showSelfDestruct()
		while(cursor_sprite.position.y<-100):#accelerate down
			speed+=0.6
			await get_tree().create_timer(0.01).timeout

@onready var explosion_holder: Node2D = $ExplosionHolder

func explodeCursor():
	await get_tree().create_timer(0.4).timeout
	var explosionInstance=explosion.instantiate()
	explosionInstance.audio=false
	explosionInstance.global_position=Vector2(61,-255)
	explosionInstance.gravity=0
	explosion_holder.add_child(explosionInstance)

var selfDestructExplosion=preload("res://scenes/SelfDestructExplosion.tscn")
func showSelfDestruct():
	await get_tree().create_timer(0.4).timeout
	var selfDestructExplosionInstance=selfDestructExplosion.instantiate()
	selfDestructExplosionInstance.audio=false
	selfDestructExplosionInstance.global_position=Vector2(-450,-40)
	selfDestructExplosionInstance.gravity=0
	selfDestructExplosionInstance.set_collision_mask_value(1,false)
	selfDestructExplosionInstance.set_collision_layer_value(1,false)
	selfDestructExplosionInstance.ok=false
	explosion_holder.add_child(selfDestructExplosionInstance)

@onready var coin: Sprite2D = $Coin

func _process(delta: float) -> void:
	cursor_sprite.position.y+=delta*speed
	coin.position.y+=delta*speed

@onready var main_menu: Node2D = $"../MainMenu"

#buttons to show and enable
@onready var control_info_button: TextureButton = $"../MainMenu/VBoxContainer/controlInfoButton"
@onready var play_button: TextureButton = $"../MainMenu/VBoxContainer/PlayButton"
@onready var exit_button: TextureButton = $"../MainMenu/VBoxContainer/ExitButton"
@onready var shop_button: TextureButton = $"../MainMenu/VBoxContainer/shopButton"
@onready var continue_button: TextureButton = $"../MainMenu/VBoxContainer/ContinueButton"

#buttons to hide and disable
@onready var back_button: TextureButton = $BackButton

@onready var buttonPress: AudioStreamPlayer = $"../../../AudioStreamPlayer"

func _on_back_button_pressed() -> void:
	buttonPress.play()
	global.switchFades(main_menu,self)
	for i in get_children():
		if i is TextureButton:
			i.disabled=true
	await get_tree().create_timer(1.8).timeout
	control_info_button.disabled=false
	exit_button.disabled=false
	play_button.disabled=false
	continue_button.disabled=false
	shop_button.disabled=false
