extends State
class_name WeaponRotation


@onready var camera : Camera3D = get_tree().get_first_node_in_group("Camera")
@export var weapon: Weapon
var rotator_x: StaticBody3D
var rotator_y: StaticBody3D
var is_on_rotator = false
var is_rotating = false
var on_rotator_y = false
var on_rotator_x = false
var initial_mouse_pos: Vector2
var initial_rotation: Vector3
var initial_weapon_pos: Vector3

func enter():
	weapon.item_rotator.show()
	rotator_x = weapon.item_rotator.rotator_x
	rotator_y = weapon.item_rotator.rotator_y
	rotator_x.set_collision_layer_value(1,true)
	rotator_x.set_collision_mask_value(1,true)
	rotator_y.set_collision_layer_value(1,true)
	rotator_y.set_collision_mask_value(1,true)
	camera = get_tree().get_first_node_in_group("Camera")
	
func update(delta):
	check_if_on_rotator()
	check_if_rotate()
	
func check_if_on_rotator():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	var ray_end = ray_origin + ray_direction * 2000
	
	var space_state = rotator_x.get_world_3d().direct_space_state
	var new_intersection = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var result = space_state.intersect_ray(new_intersection)
	if result and (result.collider == rotator_x or result.collider == rotator_y):
		is_on_rotator = true
		on_rotator_x = true
		on_rotator_y = false
	else:
		is_on_rotator = false


func check_if_rotate():
	if Input.is_action_just_pressed("left_mouse_click") and is_on_rotator:
		initial_mouse_pos = get_viewport().get_mouse_position() 
		initial_rotation = weapon.rotation 
		initial_weapon_pos = weapon.attachment_point.global_position
		is_rotating = true
	elif Input.is_action_just_pressed("left_mouse_click"):
		state_transition.emit(self, "WeaponIdle")

	if Input.is_action_pressed("left_mouse_click") and is_rotating:
		var current_mouse_pos = get_viewport().get_mouse_position()
		var mouse_delta = current_mouse_pos - initial_mouse_pos
		
		var rotation_amount = mouse_delta.y * 0.01
		weapon.rotation.x = initial_rotation.x - rotation_amount
		
		rotation_amount = mouse_delta.x * 0.01
		weapon.rotation.y = initial_rotation.y + rotation_amount
		
		var new_weapon_attachment_pos = weapon.attachment_point.to_global(Vector3.ZERO)
		var offset = initial_weapon_pos - new_weapon_attachment_pos
		weapon.global_position += offset
	elif is_rotating:
		is_rotating = false
		
		
func exit():
	weapon.item_rotator.hide()
	rotator_x.set_collision_layer_value(1,false)
	rotator_x.set_collision_mask_value(1,false)
	rotator_y.set_collision_layer_value(1,false)
	rotator_y.set_collision_mask_value(1,false)
