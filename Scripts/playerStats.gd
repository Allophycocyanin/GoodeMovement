extends Node

var experience = 50
var currentLevel = 1

const MAX_LEVEL = 4
const EXP_CAP = 100
const MAX_EXP = 400
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	levelCheck()

func levelCheck():
	currentLevel = experience % EXP_CAP

func deathCheck():
	if(experience < 0):
		# Player dies