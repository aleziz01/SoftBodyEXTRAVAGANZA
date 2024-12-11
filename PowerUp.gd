extends Area2D

@onready var powerUpComponent: Node2D = $PowerUpComponent

var isDead=false

func _process(delta: float) -> void:
	rotation+=0.05

func _on_body_entered(body: Node2D) -> void:
	var object=body.get_parent().get_parent()
	if object.name=="mainSoftBody" and !isDead and !global.gameOver:
		isDead=true
		powerUpComponent.applyPowerUp(object)
		hide()
		await get_tree().create_timer(26).timeout
		queue_free()
