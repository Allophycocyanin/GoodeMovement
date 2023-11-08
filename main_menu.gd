extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print('Main Menu Ready')
	$StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file('res://level_1.tscn')



func _on_settings_button_pressed():
	get_tree().change_scene_to_file('res://settings.tscn')


func _on_quit_button_pressed():
	get_tree().quit()
