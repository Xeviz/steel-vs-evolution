extends Control

@onready var game = get_parent()


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		#game.unpause_game()
		pass
		
func _on_continue_button_button_down():
	game.unpause_game()
