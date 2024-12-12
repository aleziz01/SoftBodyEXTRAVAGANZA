extends Node

@onready var parent = get_parent()

func _ready() -> void:
	parent.isHeat=1 #true

func _process(delta: float) -> void: #lil calculations
	if(!parent.fired):
		parent.rotation+=deg_to_rad(rad_to_deg(parent.get_angle_to(Vector2(parent.mainSoftBody.realPosx,parent.mainSoftBody.realPos-140)))+180)
