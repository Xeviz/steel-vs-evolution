extends Node3D
class_name BodyPart

@onready var state_machine = $FiniteStateMachine
@onready var collision_shape = $StaticBody3D/CollisionShape3D
var body_part_name = "BodyPart"
var should_rotate = true

func go_to_idle():
	state_machine.on_child_transition(state_machine.current_state, "BodyPartIdle")
	enable_collision()
	
func go_to_preview():
	disable_collision()
	state_machine.on_child_transition(state_machine.current_state, "BodyPartPreview")
	
	
func enable_collision():
	if collision_shape:
		collision_shape.disabled = false
		
func disable_collision():
	if collision_shape:
		collision_shape.disabled = true 
