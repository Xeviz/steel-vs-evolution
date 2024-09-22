extends Node3D
class_name BodyPart

@onready var state_machine = $FiniteStateMachine
var body_part_name = "BodyPart"

func go_to_idle():
	state_machine.on_child_transition(state_machine.current_state, "BodyPartIdle")
	
func go_to_preview():
	state_machine.on_child_transition(state_machine.current_state, "BodyPartPreview")
	
