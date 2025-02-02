extends TextureButton

@export var mainSoftBody:Node2D

@onready var bg: AnimatedSprite2D = $bg
@onready var skin_1: TextureButton = $skin1
@onready var skin_2: TextureButton = $skin2
@onready var skin_3: TextureButton = $skin3

var burntShader=preload("res://shaders/burntShader.gdshader")
var burntNoise=preload("res://shaders/BurntNoiseImg.tres")
var deepSeaShader=preload("res://shaders/DeepSea.gdshader")
var deepSeaNoise=preload("res://shaders/DeepSea.tres")
var RoyalShader=preload("res://shaders/royal.gdshader")

var RegularTexture=preload("res://art/coin.png")

@onready var buttonPress: AudioStreamPlayer = $"../../../../AudioStreamPlayer"

func _ready() -> void:
	if global.wins>=1:
		skin_1.modulate=Color(255,255,255,255)
		skin_1.material.shader=burntShader
		skin_1.material.set_shader_parameter("noise_img",burntNoise)
		skin_1.disabled=false
	if global.wins>=2:
		skin_2.modulate=Color(255,255,255,255)
		skin_2.material.shader=deepSeaShader
		skin_2.material.set_shader_parameter("noise_img",deepSeaNoise)
		skin_2.disabled=false
	if global.wins>=3:
		skin_3.modulate=Color(255,255,255,255)
		skin_3.material.shader=RoyalShader
		skin_3.disabled=false

func _on_pressed() -> void:
	buttonPress.play()
	if bg.frame==5:
		bg.play_backwards("default")
		await get_tree().create_timer(0.01).timeout
		for i in get_children():
			if i is TextureButton:
				i.visible=false
	if bg.frame==0:
		bg.play("default")
		await get_tree().create_timer(0.08).timeout
		for i in get_children():
			if i is TextureButton:
				i.visible=true

func _on_skin_1_pressed() -> void:
	buttonPress.play()
	mainSoftBody.get_child(0).material.shader=burntShader
	mainSoftBody.get_child(0).material.set_shader_parameter("noise_img",burntNoise)
	if crownInstance:
		crownInstance.queue_free()
		crownInstance=null

func _on_skin_2_pressed() -> void:
	buttonPress.play()
	mainSoftBody.get_child(0).material.shader=deepSeaShader
	mainSoftBody.get_child(0).material.set_shader_parameter("noise_img",deepSeaNoise)
	if crownInstance:
		crownInstance.queue_free()
		crownInstance=null

var crown=preload("res://scenes/crown.tscn")
var crownInstance=null
func _on_skin_3_pressed() -> void:
	buttonPress.play()
	if crownInstance:
		crownInstance.queue_free()
		crownInstance=null
	mainSoftBody.get_child(0).material.shader=RoyalShader
	crownInstance=crown.instantiate()
	crownInstance.mainSoftBody=mainSoftBody
	mainSoftBody.add_child(crownInstance)

func _on_skin_4_pressed() -> void:
	buttonPress.play()
	mainSoftBody.get_child(0).material.shader=null
	if crownInstance:
		crownInstance.queue_free()
		crownInstance=null
