extends Node2D
class_name Dungeon

var number_of_rooms : int
var occupied = [22]
var rooms = []


func generate_dungeon():
	for coords in occupied:
		var neighbours = generate_neighbours(coords)
		for neighbour in neighbours:
			if occupied.size() != number_of_rooms:
				if create_room(neighbour,occupied):
					occupied.append(neighbour)
				
			else:
				break
	
	var swaps = true
	while swaps == true:
		swaps = false
		
		for i in range(len(occupied)-1):
			if occupied[i] > occupied[i+1]:
				var temp = occupied[i+1]
				occupied[i+1] = occupied[i]
				occupied[i] = temp
				swaps = true

func list_to_int(l):
	var s = ""
	for val in l:
		s = s +(str(val))
	return int(s)

func generate_room_instances():
	for coords in occupied:
		var new_room = Room.new()
		new_room.coords = coords
		var neighbours = generate_neighbours(coords)
		var neighbour_layout = []
		for neighbour in neighbours:
			if neighbour in occupied:
				neighbour_layout.append(1)
			else:
				neighbour_layout.append(0)
				
		new_room.coords = coords
		new_room.neighbour_layout = list_to_int(neighbour_layout)
		new_room.no_enemies = randi() % 4
		rooms.append(new_room)




func generate_neighbours(coords):
	return [coords-10,coords+1,coords+10,coords-1]

func create_room(coords,occupied):
	if coords in occupied:
		return false
	
	elif neighbours_count(coords,occupied) > 1:
		return false
	
	elif randi() % 3 == 1:
		return false
	
	elif position_in_range(coords): 
		return true


func position_in_range(coords):
	if coords < 0 or (coords %10) >4 or ((coords-(coords%10))/10) >4:
		return false
	
	return true
	
func neighbours_count(coords,occupied):
	var neighbours = generate_neighbours(coords)
	var count = 0
	for neighbour in neighbours:
		if neighbour in occupied:
			count += 1
			
	return count

func room_exists(target):
	var left = 0
	var right = len(occupied)
	var mid = int((left+right)/2)
	while left<= right:
		mid = int((left+right)/2)
		if occupied[mid] == target:
			return mid
		else:
			if target > occupied[mid]:
				left = mid +1
			else:
				right = mid-1
	
	return -1
	
func enemy_killed(coord):
	var index = room_exists(coord)
	rooms[index].no_enemies -= 1
		
var dungeon_layout = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]

func dungeon_layout_visualiser():
	for coords in occupied:
		if coords >= 10:
			dungeon_layout[(coords - (coords%10))/10][coords%10] = 1
		else:
			dungeon_layout[0][coords%10] = 1

	return dungeon_layout



