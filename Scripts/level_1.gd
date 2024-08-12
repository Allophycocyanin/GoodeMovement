extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	print('level 1 loaded')

func _input(event):
	if event.is_action_pressed("return_to_main_menu"):
		get_tree().change_scene_to_file('res://Scene/Utility/main_menu.tscn')
