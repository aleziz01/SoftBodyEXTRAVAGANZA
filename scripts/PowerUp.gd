extends Area2D

@onready var powerUpComponent: Node2D = $PowerUpComponent

var isDead=false

func _process(_delta: float) -> void:
	rotation+=0.05

func _on_body_entered(body: Node2D) -> void:
	var object=body.get_parent().get_parent()
	if object.name=="mainSoftBody" and !isDead and !global.gameOver:
		isDead=true
		powerUpComponent.applyPowerUp(object)
		get_parent().get_child(0).play()
		hide()
		await get_tree().create_timer(0.1).timeout
		get_parent().get_child(0).play()
		await get_tree().create_timer(25.5).timeout
		queue_free()

var mainSoftBody: Node2D
func unload():
	while(true):
		await get_tree().create_timer(0.1).timeout
		if(global.gameOver and global_position.y+500<mainSoftBody.realPos.y):
			queue_free()
		if(!global.gameOver and global_position.y-2000>mainSoftBody.realPos.y and mainSoftBody):
			queue_free()
