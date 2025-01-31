extends Node2D

@onready var mainSoftBody: Node2D = $"../../../mainSoftBody"
@onready var projectileHolder: Node2D = $"../ProjectileHolder"

var fired=false
var angle=0
@export var isHeat=0 #false
@export var MultiTimesToFire=1
@export var timeBetweenShots=0.1
@export var timeBeforeNextBurst=0.01
@export var ProjCount=8

func _process(_delta: float) -> void:
		if mainSoftBody and global_position.y+300*isHeat>mainSoftBody.realPos.y and !fired:
			fired=true
			FIRE()

var projectile = preload("res://scenes/projectile.tscn")
var cannonExplosion = preload("res://scenes/cannon_explosion.tscn")

func FIRE():
	for i in MultiTimesToFire:
		var cannonExplosionInstance = cannonExplosion.instantiate()
		cannonExplosionInstance.global_position.x*=sign(self.position.x)
		add_child(cannonExplosionInstance)
		for j in ProjCount:
			var projectileInstance=projectile.instantiate()
			projectileHolder.add_child(projectileInstance)
			projectileInstance.global_position=global_position+Vector2(-1*randf_range(22,30),randf_range(-0.5,0.5)*isHeat+randf_range(-3,3)*int(!bool(isHeat)))
			projectileInstance.rotation=rotation
			projectileInstance.mainSoftBody=mainSoftBody
			await get_tree().create_timer(timeBetweenShots).timeout
		await get_tree().create_timer(timeBeforeNextBurst).timeout

func _enter_tree() -> void:
	unload()

func unload():
	while(true):
		await get_tree().create_timer(0.1).timeout
		if(global.gameOver and global_position.y+700<mainSoftBody.realPos.y):
			queue_free()
		if(mainSoftBody and !global.gameOver and global_position.y-2000>mainSoftBody.realPos.y):
			queue_free()
