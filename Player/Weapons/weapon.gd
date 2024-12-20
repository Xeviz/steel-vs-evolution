extends Node3D
class_name Weapon

@onready var state_machine = $FiniteStateMachine
@onready var item_rotator = $ItemRotator
@onready var weapon_area: StaticBody3D = $WeaponArea
@onready var attachment_point: Node3D = $AttachmentPoint
@onready var player = get_tree().get_first_node_in_group("Player")


var icon_refference: WeaponIcon
var weapon_name = "Weapon"
var weapon_type = "gun"
var weapon_level = 1

var upgrade_variants = {
	
}

func apply_upgrade(variant_id):
	pass

func go_to_idle():
	weapon_area.set_collision_layer_value(1,true)
	weapon_area.set_collision_mask_value(1,true)
	state_machine.on_child_transition(state_machine.current_state, "WeaponIdle")
	
func go_to_preview():
	weapon_area.set_collision_layer_value(1,false)
	weapon_area.set_collision_mask_value(1,false)
	state_machine.on_child_transition(state_machine.current_state, "WeaponPreview")
	
func go_to_reloading():
	weapon_area.set_collision_layer_value(1,false)
	weapon_area.set_collision_mask_value(1,false)
	state_machine.on_child_transition(state_machine.current_state, "WeaponReloading")
	
func go_to_rotation():
	state_machine.on_child_transition(state_machine.current_state, "WeaponRotation")
	
