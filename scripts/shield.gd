extends Area2D

@onready var timer: Timer = $Timer
@onready var mainSoftBody=get_parent()
var shieldHP

func _ready() -> void:
	shieldHP=global.Upgrades[2]
	verifyHP()

func _process(_delta: float) -> void:
	global_position=mainSoftBody.realPos
	if(global.HighScore<5):
		queue_free()

func _on_body_entered(body):
	var parentOfBody=body.get_parent().get_parent()
	if parentOfBody.name=="Node2D":
		parentOfBody.queue_free()
		shieldHP-=1
		goRed()
		verifyHP()

func goRed():
	modulate=Color(255,0,0,255)
	await get_tree().create_timer(0.1).timeout
	modulate=Color(255,255,255,255)

func verifyHP():
	if(shieldHP<=0):
		set_collision_mask_value(1,false)
		hide()
		if global.Upgrades[2]:
			timer.start()

func _on_timer_timeout() -> void:
	shieldHP=global.Upgrades[2]
	print("shown")
	show()
	set_collision_mask_value(1,true)
