extends Panel


@onready var sprite = $Sprite2D

func update(state):
	sprite.frame = state # chooses the sprite for the heart
	


