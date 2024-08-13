extends CharacterBody2D

#==================================================================================================
# Variables
#==================================================================================================
@export var Coyote_Time: float = 0.05
const JUMP_VELOCITY = -350.0
const WALK = 150
const RUN = 250
const ACCELERATION = 7
var	speed = 0
var Jump_Available: bool = true
var flip: bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	#==============================================================================================
	# Gravity Manager
	#==============================================================================================
	if not is_on_floor():
		if Jump_Available:
			get_tree().create_timer(Coyote_Time).timeout.connect(Coyote_Timeout)
		
		velocity.y += gravity * delta
	else:
		Jump_Available = true

	# Get the input direction and handle the movement/deceleration.
	var direction: float = Input.get_action_strength("move_right") \
					- Input.get_action_strength("move_left")
	
	# Checks if the sprint key is being pressed
	var sprint_pressed = Input.is_action_pressed('sprint')
	print(sprint_pressed)
	
	#==============================================================================================
	# Jump Manager
	#==============================================================================================
	if Input.is_action_just_pressed("jump") and Jump_Available:
		Jump_Available = false
		if sprint_pressed:
			velocity.y = JUMP_VELOCITY - ACCELERATION
		else:
			velocity.y = JUMP_VELOCITY

	#==============================================================================================
	# Decceleration
	#==============================================================================================
	if (direction == 0.0 && speed > 0):
		speed -=ACCELERATION
	
	#==============================================================================================
	# Horizontal Movement Manager
	#==============================================================================================
	if((velocity.x > 0 && direction < 0.0) || (velocity.x < 0 && direction > 0.0)):
		if(speed > 0 ):
			speed -= ACCELERATION * 3
			
			
	if sprint_pressed:
		print("I am sprinting")
		if	(speed <= RUN && (direction > 0.0 || direction < 0.0)):
			speed += ACCELERATION*2
	else:
		# Walk speed
		# Speed increases if moving in specified direction L|R
		print("I am walking")
		if	(speed <= WALK && (direction > 0.0 || direction < 0.0)):
			speed += ACCELERATION
		
	velocity.x = speed * direction
	#print("X: ", velocity.x, ", Speed: ", speed, ", Direction: ", direction)
	move_and_slide()

#==================================================================================================
# Coyote Time
#==================================================================================================
func Coyote_Timeout():
	Jump_Available = false
	
#==================================================================================================
# Animation Handler
#==================================================================================================
func player_animation():
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play('Mousely_walk_right')
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play('Mousely_walk_left')
	elif velocity.y < 0:
		$AnimatedSprite2D.play('Mousely_fall')
	elif velocity.y > 0:
		$AnimatedSprite2D.play('Mousely_fall')
	else:
		$AnimatedSprite2D.play('Mousely_idle')
