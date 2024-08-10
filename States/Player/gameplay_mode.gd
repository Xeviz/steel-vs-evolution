extends State
class_name GameplayMode

@export var player: CharacterBody3D

func update(delta):
	player.move_player(delta)
	player.look_at_mouse()

