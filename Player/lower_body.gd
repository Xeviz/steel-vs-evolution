extends Node3D


@onready var model = $Armature
@onready var animation_tree = $AnimationTree
@onready var animation_state = $AnimationTree.get("parameters/playback")
var is_idle = true



func go_to_idle():
	animation_state.travel("IdleNLA")
	is_idle = true
	
func go_to_walking():
	animation_state.travel("WalkingNLA")
	is_idle = false
