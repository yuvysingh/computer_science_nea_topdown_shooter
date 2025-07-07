extends Node2D
signal fade_in
signal toggle_player_movement

# Called when the node enters the scene tree for the first time.


@onready var player = preload("res://player2/player_2.tscn").instantiate()

var room_layout_dic = {0000:preload("res://Room/0000.tscn"),
0001:preload("res://Room/0001.tscn")
,0010:preload("res://Room/0010.tscn"),
0011:preload("res://Room/0011.tscn"),
0100:preload("res://Room/0100.tscn"),
0101:preload("res://Room/0101.tscn"),
0110:preload("res://Room/0110.tscn"),
0111:preload("res://Room/0111.tscn"),
1000:preload("res://Room/1000.tscn")
,1001:preload("res://Room/1001.tscn"),
1010:preload("res://Room/1010.tscn"),
1011:preload("res://Room/1011.tscn"),
1100:preload("res://Room/1100.tscn"),
1101:preload("res://Room/1101.tscn"),
1110:preload("res://Room/1110.tscn"),
1111:preload("res://Room/1111.tscn")}


@onready var dungeon = Dungeon.new()

var cur_room
var player_coords = 22


var enemy = preload("res://enemy/enemy2.tscn")
var enemy_reference_list = []


func _physics_process(delta):
	game_over()


func _ready():
	dungeon.number_of_rooms = 10
	dungeon.generate_dungeon() 
	dungeon.generate_room_instances() 
	
	print(dungeon.dungeon_layout_visualiser())

	cur_room = (room_layout_dic[dungeon.rooms[dungeon.room_exists(22)].neighbour_layout]).instantiate()
	
	spawn_enemies()
	add_child(player)
	add_child(cur_room)
	
	
	
	

func despawn_enemies():
	if enemy_reference_list == []:
		return 
	for e in enemy_reference_list:
		e.queue_free()
		
	enemy_reference_list = []

	
func spawn_enemies():
	for n in range((dungeon.rooms[dungeon.room_exists(player_coords)]).no_enemies):
		
		var new_enemy = enemy.instantiate()
		new_enemy.position.x = randf_range(-40,40)
		new_enemy.position.y = randf_range(-50,50)
		new_enemy.dead.connect(minus_one)
		enemy_reference_list.append(new_enemy)
		add_child(new_enemy)

func minus_one(dead_enemy):
	
	enemy_reference_list.erase(dead_enemy)
	dungeon.enemy_killed(player_coords)
	for room in dungeon.rooms:
		if room.no_enemies != 0:
			return
	
	get_parent().queue_free()

	
func queue_next_room():
	var parent = get_parent()
	parent.fade_in()
	despawn_enemies()
	
	cur_room.queue_free()
	cur_room = (room_layout_dic[dungeon.rooms[(dungeon.room_exists(player_coords))].neighbour_layout]).instantiate()
	call_deferred("spawn_enemies")
	add_child(cur_room)
	parent.fade_out()
	
	
func _on_left_door_body_entered(body):
	if body is CharacterBody2D and body.has_method("player"):
		
		var temp_coords = player_coords -1
		if dungeon.room_exists(temp_coords) >= 0:
			
			player_coords -= 1
			player.position = $right_marker.position
			queue_next_room()
			
			
		return
	return



func _on_right_door_body_entered(body):
	if body is CharacterBody2D and body.has_method("player"):
		
		var temp_coords = player_coords +1
		if dungeon.room_exists(temp_coords) >= 0:
		
			player_coords += 1
			player.position = $left_marker.position
			queue_next_room()
			
		return
	return


func _on_down_body_entered(body):
	if body is CharacterBody2D and body.has_method("player"):
		
		var temp_coords = player_coords +10
		if dungeon.room_exists(temp_coords) >= 0:
			
			player_coords += 10
			player.position = $up_marker.position
			queue_next_room()
			
			
		return
	return


func _on_up_body_entered(body):
	if body is CharacterBody2D and body.has_method("player"):
		var temp_coords = player_coords -10
		if dungeon.room_exists(temp_coords) >= 0:
			
			player_coords -= 10
			player.position = $down_marker.position
			queue_next_room()
			
		return
	return


func game_over():
	print(player.health)
	if player.health == 0:
		print("game_lost")
		get_parent().queue_free()
	
	





