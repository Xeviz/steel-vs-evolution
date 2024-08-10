extends Node3D
class_name Weapon

@onready var state_machine = $FiniteStateMachine

func go_to_idle():
	print("idluje ", name)
	state_machine.on_child_transition(state_machine.current_state, "WeaponIdle")
	
func go_to_preview():
	print("previewuje ", name)
	state_machine.on_child_transition(state_machine.current_state, "WeaponPreview")
