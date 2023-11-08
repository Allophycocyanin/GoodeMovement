extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print('Settings loaded')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event.is_action_pressed("return_to_main_menu"):
		get_tree().change_scene_to_file('res://main_menu.tscn')



func _on_fullscreen_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
