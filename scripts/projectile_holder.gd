extends Node2D

func _process(delta: float) -> void:
	if get_child_count()>150:
		get_child(0).dead=true
		remove_child(get_child(0))
