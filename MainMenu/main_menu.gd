extends Control

@export var play_button : Button
@export var upgrades_button : Button
@export var settings_button : Button
@export var quit_button : Button


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://GameplayMap/gameplay_map.tscn")


func _on_upgrades_button_pressed():
	pass # Replace with function body.


func _on_settings_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()


func _on_play_button_mouse_entered():
	print(play_button.theme)


func _on_play_button_mouse_exited():
	pass
