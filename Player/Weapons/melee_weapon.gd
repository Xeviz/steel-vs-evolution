extends Weapon
class_name MeleeWeapon



func go_to_cutting():
	state_machine.on_child_transition(state_machine.current_state, weapon_name + "Cutting")
