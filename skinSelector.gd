extends TextureButton

@export var mainSoftBody:Node2D

@onready var bg: Polygon2D = $bg
@onready var skin_1: TextureButton = $bg/skin1
@onready var skin_2: TextureButton = $bg/skin2
@onready var skin_3: TextureButton = $bg/skin3

var burntShader=preload("res://shaders/burntShader.gdshader")
var burntNoise=preload("res://shaders/BurntNoiseImg.tres")
var deepSeaShader=preload("res://shaders/DeepSea.gdshader")
var deepSeaNoise=preload("res://shaders/DeepSea.tres")
var RoyalShader=preload("res://shaders/royal.gdshader")

func _ready() -> void:
	if global.wins>=1:
		skin_1.material.shader=burntShader
		skin_1.material.set_shader_parameter("noise_img",burntNoise)
		skin_1.show()
	if global.wins>=2:
		skin_2.material.shader=deepSeaShader
		skin_2.material.set_shader_parameter("noise_img",deepSeaNoise)
		skin_2.show()
	if global.wins>=3:
		skin_3.material.shader=RoyalShader
		skin_3.show()

func _on_pressed() -> void:
	bg.visible=!bg.visible

func _on_skin_1_pressed() -> void:
	pass # Replace with function body.

func _on_skin_2_pressed() -> void:
	pass # Replace with function body.

func _on_skin_3_pressed() -> void:
	pass # Replace with function body.
