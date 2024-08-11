extends Node3D
class_name Weapon

@onready var state_machine = $FiniteStateMachine
var weapon_name = "Weapon"

func go_to_idle():
	print("idluje ", name)
	state_machine.on_child_transition(state_machine.current_state, "WeaponIdle")
	
func go_to_preview():
	print("previewuje ", name)
	state_machine.on_child_transition(state_machine.current_state, "WeaponPreview")
	
func go_to_reloading():
	print("reloaduje", name)
	state_machine.on_child_transition(state_machine.current_state, "WeaponReloading")
