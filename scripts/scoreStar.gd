extends Area2D

@export var scoreValue:int=1
var isDead=false

func _on_body_entered(body: Node2D) -> void:
	var object=body.get_parent().get_parent()
	if object.name=="mainSoftBody" and !isDead and !global.gameOver:
		isDead=true
		global.starScore+=scoreValue
		if get_parent().get_child(0) is AudioStreamPlayer:
			get_parent().get_child(0).pitch_scale=randf_range(0.95,1.05)
			get_parent().get_child(0).play()
		else:
			get_parent().get_parent().get_parent().get_parent().get_child(1).get_child(0).get_child(0).pitch_scale=randf_range(0.95,1.05)
			get_parent().get_parent().get_parent().get_parent().get_child(1).get_child(0).get_child(0).play()
		queue_free()

func _ready() -> void:
	unload()
	if(global.Upgrades[4]>0):
		scoreValue*=global.StarUpgradesTimes[global.Upgrades[4]-1]
		scoreValue+=global.StarUpgradesPlus[global.Upgrades[4]-1]

var mainSoftBody: Node2D

func unload():
	while(true):
		await get_tree().create_timer(0.1).timeout
		if(global.gameOver and global_position.y+500<mainSoftBody.realPos.y):
			queue_free()
		if(!global.gameOver and global_position.y-2000>mainSoftBody.realPos.y and mainSoftBody):
			queue_free()
