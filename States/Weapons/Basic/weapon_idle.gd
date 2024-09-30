extends State
class_name WeaponIdle

@export var weapon: Weapon
@onready var camera : Camera3D = get_tree().get_first_node_in_group("Camera")
var is_on_weapon = false
var time_to_preview: float
var paralyze_time: float

func enter():
	paralyze_time = 0.1
	time_to_preview = 0.25
	if weapon is not MeleeWeapon:
		print(weapon)
		weapon.fired_bullets.clear()
		weapon.stored_bullets.clear()
		
		
		
func update(delta):
	print(paralyze_time)
	check_if_on_weapon()
	if paralyze_time<=0:
		check_if_go_to_rotation(delta)
	else:
		paralyze_time-=delta
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
		
func check_if_go_to_rotation(delta):
	if Input.is_action_pressed("left_mouse_click") and is_on_weapon:
		time_to_preview-=delta
		print(str(time_to_preview))
		if time_to_preview<=0:
			weapon.go_to_preview()
	elif Input.is_action_just_released("left_mouse_click") and is_on_weapon:
		state_transition.emit(self, "WeaponRotation")
		time_to_preview = 0.15
	else:
		time_to_preview = 0.15
		
		
