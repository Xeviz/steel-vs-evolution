extends Node3D


@onready var model = $Armature
@onready var animation_tree = $AnimationTree
@onready var animation_state = $AnimationTree.get("parameters/playback")
@onready var lower_collider_area = $LowerBodyPlayer
@onready var upper_collider_area = $UpperBodyPart1
var is_idle = true



func go_to_idle():
	animation_state.travel("IdleNLA")
	is_idle = true
	
func go_to_walking():
	animation_state.travel("WalkingNLA")
	is_idle = false
