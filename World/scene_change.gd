extends Node

@onready var anim = $AnimationPlayer
@onready var hearts_container = $DungeonScene/CanvasLayer/hearts
@onready var dungeon = $DungeonScene
var player




# Called when the node enters the scene tree for the first time.
func _ready():
	
	start_dungeon()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fade_in():
	anim.play("fade_in")


func fade_out():
	anim.play("fade_out")


func start_dungeon(): # called when start game signal emitted
	
	player = dungeon.player
	hearts_container.set_max_hearts(3)
	player.damaged.connect(hearts_container.update_hearts)


