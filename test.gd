extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var dungeon = Dungeon.new()
	dungeon.number_of_rooms = 7
	dungeon.generate_dungeon()
	print(dungeon.dungeon_layout_visualiser())
	print(dungeon.occupied)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
