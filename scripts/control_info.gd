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
		explode()
		while(cursor_sprite.position.y<-100):#accelerate down
			speed+=0.6
			await get_tree().create_timer(0.01).timeout

@onready var explosion_holder: Node2D = $ExplosionHolder

func explode():
	await get_tree().create_timer(0.4).timeout
	var explosionInstance=explosion.instantiate()
	explosionInstance.global_position=Vector2(61,-255)
	explosion_holder.add_child(explosionInstance)

func _process(delta: float) -> void:
	cursor_sprite.position.y+=delta*speed

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
	back_button.disabled=true
	await get_tree().create_timer(1.2).timeout
	control_info_button.disabled=false
	exit_button.disabled=false
	play_button.disabled=false
	continue_button.disabled=false
	shop_button.disabled=false
	
