extends CharacterBody2D

@export var Coyote_Time: float = 0.3
const JUMP_VELOCITY = -350.0
const WALK = 150
const RUN = 300
const ACCELERATION = 10
var	speed = 0
var Jump_Available: bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var sprinting = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if Jump_Available:
			get_tree().create_timer(Coyote_Time).timeout.connect(Coyote_Timeout)
		
		velocity.y += gravity * delta
	else:
		Jump_Available = true

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var sprint_pressed = Input.is_action_just_pressed('sprint')

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and Jump_Available:
		Jump_Available = false
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
	
	# player_animation()
	move_and_slide()

func Coyote_Timeout():
	Jump_Available = false
	
	# Handles Movement Animation
func player_animation():
	if velocity.x > 0:
		$AnimatedSprite2D.play("walk_right")
	elif velocity.x < 0:
		$AnimatedSprite2D.play('walk_left')
	else:
		$AnimatedSprite2D.play('fall')
