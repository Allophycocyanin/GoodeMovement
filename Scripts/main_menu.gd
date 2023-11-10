extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print('Main Menu Ready')
	$VBoxContainer/StartButton.grab_focus()
	
	# Disable mouse input
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_button_pressed():
	get_tree().change_scene_to_file('res://Scene/level_1.tscn')

func _on_settings_button_pressed():
	get_tree().change_scene_to_file('res://Scene/settings_menu.tscn')


func _on_quit_button_pressed():
	get_tree().quit()
