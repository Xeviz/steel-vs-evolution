extends State
class_name CustomizationMode
@export var weapons: Node3D
@export var player: CharacterBody3D

func enter():
	var all_weapons = weapons.get_children()
	for weapon in all_weapons:
		weapon.go_to_idle()


func update(delta):
	if player.is_on_the_map == true:
		state_transition.emit(self, "GameplayMode")
		var all_weapons = weapons.get_children()
		for weapon in all_weapons:
			weapon.go_to_reloading()
		
