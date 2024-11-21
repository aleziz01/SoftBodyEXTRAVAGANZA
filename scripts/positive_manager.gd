extends Node2D


func _ready() -> void:
	run()

var rng=RandomNumberGenerator.new()
func run() -> void:
	while(true):
		await get_tree().create_timer(0.1).timeout
		#have separate spawn functions for all positive objects.
