extends Node2D

var menu_music = load("res://data/audio/music/thumping_around.wav")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_music():
	$Music.stream
	$Music.play()
