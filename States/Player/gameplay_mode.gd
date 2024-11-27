extends State
class_name GameplayMode

@export var player: CharacterBody3D

func enter():
	player.lower_body.disable_colliders()
	player.player_collision_shape.disabled = false
	var all_weapons = player.lower_body.upper_body.weapons.get_children()
	for weapon in all_weapons:
		if weapon is not MeleeWeapon:
			weapon.go_to_reloading()
		else:
			weapon.go_to_cutting()

func physics_update(delta):
	if Input.is_action_just_pressed("ui_accept"):
		state_transition.emit(self, "CustomizationMode")
	else:
		player.move_player(delta)
		player.look_at_mouse()
		
func exit():
	player.lower_body.enable_colliders()
	player.player_collision_shape.disabled = true
