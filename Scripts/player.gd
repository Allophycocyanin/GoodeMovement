extends CharacterBody2D

<<<<<<< HEAD
=======
#==================================================================================================
# Variables
#==================================================================================================
@export var Coyote_Time: float = 0.05
>>>>>>> Ethan
const JUMP_VELOCITY = -350.0
const WALK = 150
const RUN = 300
const ACCELERATION = 10
var	speed = 0
<<<<<<< HEAD
=======
var Jump_Available: bool = true
var sprinting = false
>>>>>>> Ethan

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

<<<<<<< HEAD
var sprinting = false
=======
>>>>>>> Ethan

func _physics_process(delta):
	#==============================================================================================
	# Gravity Manager
	#==============================================================================================
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	var direction: float = Input.get_action_strength("move_right") \
					- Input.get_action_strength("move_left")
	
	var sprint_pressed = Input.is_action_just_pressed('sprint')
<<<<<<< HEAD

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
=======
	
	#==============================================================================================
	# Jump Manager
	#==============================================================================================
	if Input.is_action_just_pressed("jump") and Jump_Available:
		Jump_Available = false
>>>>>>> Ethan
		if sprinting:
			velocity.y = JUMP_VELOCITY - ACCELERATION
		else:
			velocity.y = JUMP_VELOCITY

	#==============================================================================================
	# Decceleration
	#==============================================================================================
	if (direction == 0.0 && speed > 0):
		print("direction detected")
		speed = speed - ACCELERATION
		print("new speed ", speed)
	
	#==============================================================================================
	# Sprint Manager
	#==============================================================================================
	if sprint_pressed:
		sprinting = true
	elif Input.is_action_just_released('sprint'):
		sprinting = false

	if sprinting:
		if	(speed <= RUN):
			speed += ACCELERATION
		velocity.x = direction * speed
	else:
		if	(speed <= WALK && (direction > 0.0 || direction < 0.0)):
			speed += ACCELERATION
<<<<<<< HEAD
		velocity.x = direction *	speed
	
	player_animation()
=======
		velocity.x = direction * speed
		
	print("X: ", velocity.x, ", Speed: ", speed, ", Direction: ", direction)
>>>>>>> Ethan
	move_and_slide()
	
	# Handles Movement Animation
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
