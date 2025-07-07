extends CharacterBody2D
	
	
	

var state= "idle"
@onready var aniamtionTree= $AnimationTree
func _physics_process(delta):
	flip_h()
	match state:
		"idle":
			
			aniamtionTree["parameters/conditions/is_idle"] = true
			aniamtionTree["parameters/conditions/is_walking"] = false
			
		"surround":
			move(player.global_position + vector_on_circle(r * 2 * PI),delta)
			
			
			
		"attack":
			
			aniamtionTree["parameters/conditions/is_idle"] = false
			aniamtionTree["parameters/conditions/is_walking"] = true
			move(player.global_position,delta)
			if (player.global_position-global_position).length() < 15:
				state = "hit"
				
		"hit":
			
			aniamtionTree["parameters/conditions/is_attacking"] = true
			var attack_vector = velocity.normalized()
			player.damage(attack_vector)
			
	


@onready var surround_timer = $surround_timer
@onready var animation = $AnimationPlayer

 
signal moved
signal dead

const speed = 75
func move(target, delta):
	
	var direction = (target-global_position).normalized()
	var final_velocity = direction * speed
	var steer = (final_velocity - velocity) * delta 
	velocity += steer
	move_and_slide()

var random_num = RandomNumberGenerator.new()
var r
func generate_random_num():
	random_num.randomize()
	r = random_num.randf()			
		

func vector_on_circle(random):
	var radius = 50
	return radius * Vector2(cos(random),sin(random))


func flip_h():
	if velocity.x >0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true

var player
func _on_detection_zone_body_entered(body):
	
	if body is CharacterBody2D and body.has_method("player"):
		
		player = body
		state = "surround"
		

func _on_surround_timer_timeout():
	
	state = "attack"
	print("attack")
	

func _ready():
	generate_random_num()


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "hit":
		state = "surround"
		surround_timer.start()	
		

func _on_hitbox_area_entered(area):
	if area.has_method("arrow"):
		dead.emit(self)
		queue_free()
		
		

aniamtionTree["parameters/conditions/is_attacking"] = false
			aniamtionTree["parameters/conditions/is_idle"] = false
			aniamtionTree["parameters/conditions/is_walking"] = true
if surround_timer.is_stopped():
				surround_timer.start()
