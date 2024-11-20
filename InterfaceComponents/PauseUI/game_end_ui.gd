extends Control

@onready var game = get_parent()
@onready var game_result_label: Label = $GameResultLabel
@onready var added_coins_label: Label = $AddedCoinsLabel

func set_labels(game_result):
	if game_result:
		game_result_label.text = "YOU HAVE WON"
		added_coins_label.text = "+" + str(global_data.slain_enemies + 1000) + " coins"
	else:
		game_result_label.text = "YOU HAVE LOST"
		added_coins_label.text = "+" + str(global_data.slain_enemies) + " coins"
	

func _on_exit_button_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://InterfaceComponents/MainMenuUI/main_menu.tscn")
