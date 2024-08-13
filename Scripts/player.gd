extends CharacterBody2D

const JUMP_VELOCITY = -350.0
const WALK = 150
const RUN = 300
const ACCELERATION = 10
var	speed = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var sprinting = false

func _physics_process(delta):
	#==============================================================================================
	# Gravity Manager
	#==============================================================================================
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var sprint_pressed = Input.is_action_just_pressed('sprint')

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if sprinting:
			velocity.y = JUMP_VELOCITY - ACCELERATION
		else:
			velocity.y = JUMP_VELOCITY

	#==============================================================================================
	# Idle Decceleration
	#==============================================================================================
	if (direction == 0.0 && speed != 0):
		if(speed < 0):
			speed += ACCELERATION
		if(speed > 0):
			speed -= ACCELERATION
	
	player_animation()
	move_and_slide()
	
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
