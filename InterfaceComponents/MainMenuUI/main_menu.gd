extends Control

@export var play_button : Button
@export var upgrades_button : Button
@export var settings_button : Button
@export var quit_button : Button

@export var customization_scene : PackedScene
@export var player_scene : PackedScene



func _ready() -> void:
	background_music_player.play_menu_music()
	global_data.restart_session()
	global_data.load_menu_progress()

func _on_play_button_pressed():
	
	var new_player = player_scene.instantiate()
	global_data.player = new_player
	var new_customization_scene = customization_scene.instantiate()
	new_customization_scene.add_child(new_player)
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(new_customization_scene)
	get_tree().current_scene = new_customization_scene


func _on_upgrades_button_pressed():
	get_tree().change_scene_to_file("res://InterfaceComponents/MenuProgressionUI/MenuProgressionInterface.tscn")


func _on_settings_button_pressed():
	pass


func _on_quit_button_pressed():
	get_tree().quit()


func _on_play_button_mouse_entered():
	pass


func _on_play_button_mouse_exited():
	pass
