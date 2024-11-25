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

func _on_back_button_pressed() -> void:
	global.switchFades(main_menu,self)
