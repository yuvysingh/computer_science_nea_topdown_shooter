extends HBoxContainer

@onready var heartGUI = preload("res://Player/each_heart.tscn")
var heart_composition = [0,0,0]

func set_max_hearts(max: int): # displays full hearts
	
	heart_composition[0] = max
	for i in range(max):
		var heart = heartGUI.instantiate()
		add_child(heart)


func update_hearts(health): # updates hearts`
	
	if heart_composition[1] == 1:
		heart_composition[1] = 0
		heart_composition[2] +=1 
	
	else:
		heart_composition[0] -= 1
		heart_composition[1] +=1 
	
	
	
	var hearts= get_children()
	
	for i in range(len(hearts)):
		if heart_composition[0] >= i +1:
			hearts[i].update(0)
		
		elif heart_composition[1] == 1 and heart_composition[0] == i:
			hearts[i].update(2)
		
		elif i >= heart_composition[0] +heart_composition[1] :
			hearts[i].update(4)  
		
	
	
	
			
		
	
	
