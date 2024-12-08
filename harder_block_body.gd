extends Node2D

@onready var mainSoftBody: Node2D = $"../../../mainSoftBody"
@onready var BlockHolder: Node2D = $"../../../NegativeManager/BlockHolder"

var regularBlock=preload("res://scenes/rectangleSoftBody.tscn")

func _process(delta: float) -> void:
	global_position=Vector2(mainSoftBody.realPosx,mainSoftBody.realPos-1000)

func _on_timer_timeout() -> void:
	var BlockInstance=regularBlock.instantiate()
	BlockInstance.mainSoftBody=mainSoftBody
	BlockInstance.global_position=Vector2(mainSoftBody.realPosx,mainSoftBody.realPos-2000)
	BlockHolder.add_child(BlockInstance)
	fadeLightOut()
	await get_tree().create_timer(3).timeout
	queue_free()
	
@onready var light: PointLight2D = $PointLight2D

func fadeLightOut() -> void:
	while(light.energy>0):
		await get_tree().create_timer(0.01).timeout
		light.energy-=0.1
