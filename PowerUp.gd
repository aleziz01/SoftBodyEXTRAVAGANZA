extends Area2D

@onready var powerUpComponent: Node2D = $PowerUpComponent

var isDead=false
func _on_body_entered(body: Node2D) -> void:
	var object=body.get_parent().get_parent()
	if object.name=="mainSoftBody" and !isDead and !global.gameOver:
		isDead=true
		powerUpComponent.applyPowerUp(object)
		queue_free()
