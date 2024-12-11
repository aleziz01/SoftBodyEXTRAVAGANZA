extends Node2D

#no cd powerup
func applyPowerUp(body):
	global.noCD=true
	await get_tree().create_timer(5.0+5.0*float(global.Upgrades[5])/2.0).timeout
	global.noCD=false
