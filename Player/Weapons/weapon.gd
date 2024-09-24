extends Node3D
class_name Weapon

@onready var state_machine = $FiniteStateMachine
var weapon_name = "Weapon"
var weapon_type = "gun"

func go_to_idle():
	state_machine.on_child_transition(state_machine.current_state, "WeaponIdle")
	
func go_to_preview():
	state_machine.on_child_transition(state_machine.current_state, "WeaponPreview")
	
func go_to_reloading():
	state_machine.on_child_transition(state_machine.current_state, "WeaponReloading")
	
