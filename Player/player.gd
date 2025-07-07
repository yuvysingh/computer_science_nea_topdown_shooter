extends CharacterBody2D

const speed = 75
@onready var player_body = $AnimationPlayer
@onready var sprite = $AnimatedSprite2D
@onready var attack_cooldown = $Timer

signal update_health # emit with health parameter when damage taken

var stop_moving= false
var dir = "down"
var attack_ip


func player():
	pass

func stop_movement():
	if stop_moving == false:
		stop_moving = true
		return
	
	else:
		stop_moving = false
		return
	
func run():
		
	if Input.is_action_pressed("left"):
		dir = "left"
		velocity.x = -speed
		velocity.y = 0	
	
	elif Input.is_action_pressed("right"):
		dir = "right"
		velocity.x = speed
		velocity.y = 0

	elif Input.is_action_pressed("up"):
		dir = "up"
		velocity.y = -speed
		velocity.x = 0
	
	elif Input.is_action_pressed("down"):
		dir = "down"
		velocity.y = speed
		velocity.x = 0
	
	else:
		velocity = Vector2.ZERO

func flip_h():
	if dir == "left":
		sprite.flip_h = true
		return
	
	else:
		sprite.flip_h = false
		return

func side():
	if dir == "left" or dir == "right":
		return true
	else:
		return false
	
func animate():
	
	if velocity == Vector2.ZERO:
		if side():
			player_body.play("side_idle")
		
		else:
			player_body.play(dir + "_idle")
	
	else:
		if side():
			player_body.play("side_walk")
		
		else:
			player_body.play(dir + "_walk")
	
func attack():
	
	if Input.is_action_just_pressed("attack") and attack_cooldown.is_stopped() and attack_ip == false :
		attack_cooldown.start()
		attack_ip = true
	
		if side():
			
			player_body.play("side_attack")
		
		else:
			player_body.play(dir + "_attack")
	
func _physics_process(delta):
	flip_h()
	
	
	animate()
	
	if stop_moving:
		return
	
	attack()
	run()
	
	move_and_slide()






#when attack is clicked
#play attack animation 
#when 

#enemy
#random movement
#one attack
#simple attack logic

#enemies stay in their room
	












#func _on_animation_player_animation_finished(anim_name):
	#if anim_name == "side_attack" or anim_name == "up_attack" or anim_name == "down_attack":
		#attack_ip= false
		#pass

#func _on_attack_zone_body_entered(body):
	#print("called")
	#if body.has_method("enemy") :
		#body.damage()
