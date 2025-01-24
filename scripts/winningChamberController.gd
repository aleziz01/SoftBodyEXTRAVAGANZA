extends Node2D

func _ready() -> void:
	global.wins+=1
	$TextController/VBoxContainer/StarsEarnedFromWinning.text="You got an extra " + str(global.winningDistance) + " stars!"
	global.starScore+=global.winningDistance
	$TextController/VBoxContainer/StarsEarnedFromRun.text="Stars earned this run: " + str(global.starScore-global.initialStarScore)
	$TextController/VBoxContainer/Time.text="Time: " + str(global.time[0]) + "h " + str(global.time[1]) + "m " + str(global.time[2]) + "s"
	match global.wins:
		1:
			pass
		2:
			pass
		3:
			pass
