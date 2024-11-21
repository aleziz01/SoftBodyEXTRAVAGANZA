extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture.fill_to.x=0.8
	texture.fill_to.y=0.2

func _process(_delta: float) -> void:
	texture.fill_to.x-=0.01
	texture.fill_to.x=clamp(texture.fill_to.x,0.501,0.8)
	texture.fill_to.y+=0.01
	texture.fill_to.y=clamp(texture.fill_to.x,0.2,0.501)
