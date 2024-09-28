extends Control

@onready var game = get_parent()
@onready var unpause_delay = 0.3


func _process(delta):
	unpause_delay-=delta
	if unpause_delay<0 and Input.is_action_just_pressed("ui_cancel"):
		game.unpause_game()
		
func _on_continue_button_button_down():
	game.unpause_game()
