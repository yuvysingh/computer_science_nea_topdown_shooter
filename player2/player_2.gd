extends CharacterBody2D
const speed = 100

signal damaged



func _ready():
	pass
	
#called every frame
func _physics_process(delta):
	
	shoot_bow() 
	movement()
	movement_direction(velocity)
	bow_equipped()
	if bow_equipeed:
		state = "attack"
		direction = bow_direction()
		
	$AnimatedSprite2D.play(direction+"_"+state)
	
	bow_direction()
	
	
func movement():
	# type set direction to 2D vectors
	var direction: Vector2
	# intially set direction to the zero vector
	direction = Vector2.ZERO
	
	# check if a movement button is being pressed
	if Input.is_action_pressed("left"):
		# if it is being pressed we add that component to our direction
		direction += Vector2.LEFT
	
	if Input.is_action_pressed("right"):
		direction += Vector2.RIGHT
	
	if Input.is_action_pressed("up"):
		direction += Vector2.UP
	
	if Input.is_action_pressed("down"):
		direction += Vector2.DOWN
	
	
	direction = direction.normalized()
	# set our player velocity
	velocity = direction * speed
	
	
	# move_and_slide moves the player
	move_and_slide()




func bow_direction(): 
	var dir: Vector2
	var mouse_dir : String
	dir = (get_global_mouse_position()- self.position).normalized()
	var dot = (Vector2.RIGHT).dot(dir)
	
	if dot > 0.92:
		mouse_dir = "e"
	
	elif 0.92 > dot and dot > 0.382:
		if dir.y < 0:
			mouse_dir = "ne"
		
		else:
			mouse_dir = "se"
	
	elif dot <0.382 and dot > -0.382:
		if dir.y < 0:
			mouse_dir = "n"
		
		else:
			mouse_dir = "s"
	
	elif dot < -0.382 and dot > - 0.92:
		if dir.y < 0:
			mouse_dir = "nw"
		
		else:
			mouse_dir = "sw"
	
	else:
		mouse_dir = "w"
	
	return mouse_dir
	

@onready var bow_cooldown_timer = $Timer

func shoot_bow():
	if bow_equipeed and bow_cooldown_timer.is_stopped() and Input.is_action_just_pressed("attack"):
		shoot()	
		bow_cooldown_timer.start()



var bow_equipeed = false

func bow_equipped():
	if Input.is_action_just_pressed("equip"):
		bow_equipeed = !bow_equipeed
		if bow_equipeed:
			state = "attack"
			
		else:
			state =""
		
	else:
		pass




	
var arrow = preload("res://player2/area_2d.tscn")

@onready var marker = $Marker2D
func shoot():
	var new_arrow= arrow.instantiate()
	marker.look_at(get_global_mouse_position())
	new_arrow.rotation = marker.rotation
	new_arrow.global_position = marker.global_position
	add_child(new_arrow)
	


func player():
	pass
	
var health = 3
func damage(enemy_attack_direction):
	if $damage.is_stopped():
		$damage.start()
		health -= 0.5
		
		
		damaged.emit(health)
		
		var total = 0
		while abs(position.x) <50 and abs(position.y) <60 and total < 21:
			total += 1
			position += enemy_attack_direction 
		
		
	
	
var direction = "n"
var state = ""
func movement_direction(movement_vector):
		
	
	if movement_vector == Vector2.ZERO:
		state = "idle"
		return
		
	
	else:
		if movement_vector.x >0:
			state = "walk"
			if movement_vector.y <0:
				direction = "ne"
			elif movement_vector.y == 0:
				direction = "e"
			
			elif movement_vector.y >0:
				direction= "se"
			
		
		elif movement_vector.x < 0:
			state = "walk"
			if movement_vector.y < 0:
				direction = "nw"
			elif movement_vector.y == 0:
				direction = "w"
			
			elif movement_vector.y >0:
				direction= "sw"
			
			
			
		elif movement_vector.x == 0:
			state = "walk"
			if movement_vector.y <0:
				direction = "n"
			
			else:
				direction = "s"
			
		
				




	
	2
