extends State
class_name CustomizationMode
@export var player: CharacterBody3D

func enter():
	if player.lower_body.upper_body:
		var all_weapons = player.lower_body.upper_body.weapons.get_children()
		for weapon in all_weapons:
			weapon.go_to_idle()
		player.reset_rotations()
		player.lower_body.go_to_idle()


		
