extends Area2D

@export var scoreValue:int=1
var isDead=false
func _on_body_entered(body: Node2D) -> void:
	var object=body.get_parent().get_parent()
	if object.name=="mainSoftBody" and !isDead and !global.gameOver:
		isDead=true
		global.starScore+=scoreValue
		queue_free()

func _ready() -> void:
	unload()
	
@onready var mainSoftBody: Node2D = $"../../../mainSoftBody"

func unload():
	while(true):
		await get_tree().create_timer(0.1).timeout
		if(global.gameOver and global_position.y+500<mainSoftBody.realPos):
			queue_free()
