extends State
class_name WeaponIdle

@export var weapon: Weapon
@onready var camera : Camera3D = get_tree().get_first_node_in_group("Camera")
var is_on_weapon = false


func enter():
	if weapon is not MeleeWeapon:
		print(weapon)
		weapon.fired_bullets.clear()
		weapon.stored_bullets.clear()
		
		
		
func update(delta):
	check_if_on_weapon()
	check_if_go_to_rotation()
	
func check_if_on_weapon():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	var ray_end = ray_origin + ray_direction * 2000
	
	var space_state = weapon.get_world_3d().direct_space_state
	var new_intersection = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var result = space_state.intersect_ray(new_intersection)
	if result and result.collider == weapon.weapon_area:
		is_on_weapon = true
	else:
		is_on_weapon = false
		
func check_if_go_to_rotation():
	if Input.is_action_just_pressed("left_mouse_click") and is_on_weapon:
		state_transition.emit(self, "WeaponRotation")
		
