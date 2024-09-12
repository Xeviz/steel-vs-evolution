extends State
class_name GameplayMode

@export var player: CharacterBody3D
@export var weapons: Node3D

func enter():
	var all_weapons = weapons.get_children()
	for weapon in all_weapons:
		weapon.go_to_reloading()

func update(delta):
	if Input.is_action_just_pressed("ui_accept"):
		state_transition.emit(self, "CustomizationMode")
	else:
		player.move_player(delta)
		player.look_at_mouse()
