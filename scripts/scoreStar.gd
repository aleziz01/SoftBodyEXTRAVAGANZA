extends Area2D

@export var scoreValue:int=1
var isDead=false
func _on_body_entered(body: Node2D) -> void:
	var object=body.get_parent().get_parent()
	if object.name=="mainSoftBody" and !isDead and !global.gameOver:
		isDead=true
		global.starScore+=scoreValue
		queue_free()
