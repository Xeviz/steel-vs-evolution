extends Node3D
class_name Weapon

@onready var state_machine = $FiniteStateMachine
var weapon_name = "Weapon"
var weapon_type = "gun"
var weapon_level = 1

var upgrade_variants = {
	
}

func apply_upgrade(variant_id):
	pass

func go_to_idle():
	state_machine.on_child_transition(state_machine.current_state, "WeaponIdle")
	
func go_to_preview():
	state_machine.on_child_transition(state_machine.current_state, "WeaponPreview")
	
func go_to_reloading():
	state_machine.on_child_transition(state_machine.current_state, "WeaponReloading")
	
