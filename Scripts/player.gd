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
	# Add the gravity.
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

	if (direction == 0):
		speed -= ACCELERATION

	if sprint_pressed:
		sprinting = true
	elif Input.is_action_just_released('sprint'):
		sprinting = false

	if sprinting:
		if	(speed <= RUN):
			speed += ACCELERATION
		velocity.x = direction *	speed
	else:
		if	(speed <= WALK):
			speed += ACCELERATION
		velocity.x = direction *	speed
	
	player_animation()
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
