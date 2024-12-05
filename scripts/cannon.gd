extends Node2D

@onready var mainSoftBody: Node2D = $"../../../mainSoftBody"

var fired=false
var angle=0

func _ready() -> void:
	print("spawned", global_position)

func _process(_delta: float) -> void:
	if global_position.y+100>mainSoftBody.realPos and !fired:
		fired=true
		FIRE()

var projectile = preload("res://scenes/projectile.tscn")
var cannonExplosion = preload("res://scenes/cannon_explosion.tscn")

func FIRE():
	var cannonExplosionInstance = cannonExplosion.instantiate()
	cannonExplosionInstance.global_position.x*=sign(self.position.x)
	add_child(cannonExplosionInstance)
	for i in 8:
		var projectileInstance=projectile.instantiate()
		add_child(projectileInstance)
		projectileInstance.position=Vector2(-1*randf_range(22,37),randf_range(-3,1))
		await get_tree().create_timer(0.1).timeout

func _enter_tree() -> void:
	unload()

func unload():
	while(true):
		await get_tree().create_timer(0.1).timeout
		if(global.gameOver and global_position.y+700<mainSoftBody.realPos):
			queue_free()
		if(!global.gameOver and global_position.y-2000>mainSoftBody.realPos and mainSoftBody):
			queue_free()
