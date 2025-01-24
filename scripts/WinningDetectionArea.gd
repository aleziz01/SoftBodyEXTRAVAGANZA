extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.get_parent().get_parent().name!="MainSoftBody":
		body.queue_free()
