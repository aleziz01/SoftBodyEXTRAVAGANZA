extends Node2D

@onready var mainSoftBody: Node2D = $"../../../mainSoftBody"
@onready var BlockHolder: Node2D = $"../../../NegativeManager/BlockHolder"

var regularBlock=preload("res://scenes/rectangleSoftBody.tscn")

var pos:Vector2

func _ready() -> void:
	UpdateSpeed()

var degreeOfLerp=0
var speed=0
func UpdateSpeed() -> void:
	while(true):
		if(global_position.x<mainSoftBody.realPosx):
			speed+=15
		else:
			speed-=15
		speed=clamp(speed,-1000,1000)
		await get_tree().create_timer(0.005).timeout

func _process(delta: float) -> void:
	global_position.x=clamp(global_position.x+delta*speed,-550,550)
	if(global_position.x>545 or global_position.x<-545):
		speed=0

var Block = preload("res://art/placeholder/block.png")

func _on_timer_timeout() -> void:
	var BlockInstance=regularBlock.instantiate()
	BlockInstance.mainSoftBody=mainSoftBody
	BlockInstance.global_position=Vector2(global_position.x+speed/300,mainSoftBody.realPos-1000)
	BlockInstance.get_child(0).mass=1
	BlockInstance.get_child(0).constant_force=Vector2(0,500)
	BlockInstance.get_child(0).gravity_scale=4
	BlockInstance.get_child(0).texture=Block
	BlockInstance.rotation=randf_range(0,360)
	BlockHolder.add_child(BlockInstance)
	fadeLightOut()
	await get_tree().create_timer(3).timeout
	queue_free()
	
@onready var light: PointLight2D = $PointLight2D

func fadeLightOut() -> void:
	while(light.energy>0):
		await get_tree().create_timer(0.01).timeout
		light.energy-=0.1


func _on_death_timer_timeout() -> void:
	queue_free()
