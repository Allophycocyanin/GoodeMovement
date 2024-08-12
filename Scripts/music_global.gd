extends Node2D

var menu_music = load("res://Data/audio/music/Tall Tale.wav")
var level_01_music = load('res://data/audio/music/vanilla_roll.wav')
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_music():
	$Music.stream = menu_music
	$Music.play()

func stop_music():
	$Music.stream = menu_music
	$Music.stop()

func play_music_01():
	$Music.stream = level_01_music
	
	$Music.play()

func stop_music_01():
	$Music.stream = level_01_music
	$Music.stop()
