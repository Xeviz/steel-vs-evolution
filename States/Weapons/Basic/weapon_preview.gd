extends State
class_name WeaponPreview


@export var weapon : Weapon
@onready var camera : Camera3D = get_tree().get_first_node_in_group("Camera")
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("Player")
@onready var player_lower_body : CharacterBody3D = get_tree().get_first_node_in_group("Player").lower_body.lower_collider_area
@onready var player_upper_body : CharacterBody3D = get_tree().get_first_node_in_group("Player").lower_body.upper_collider_area
@onready var attachment_point : Node3D = weapon.get_node("AttachmentPoint")

var is_on_player = false
var position_on_screen: Vector3
var collision_point_with_player: Vector3

func update(_delta: float):
	check_if_on_player()
	display_weapon()
	check_if_add_weapon()
		
func check_if_on_player():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	var ray_end = ray_origin + ray_direction * 2000
	
	var space_state = player.get_world_3d().direct_space_state
	var new_intersection = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var result = space_state.intersect_ray(new_intersection)
	if result and (result.collider == player or result.collider == player_lower_body or result.collider == player_upper_body):
		collision_point_with_player = result.position
		is_on_player = true
	else:
		is_on_player = false
		
func display_weapon():
	if is_on_player == false:
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_direction = camera.project_ray_normal(mouse_pos)
		var preview_pos = ray_origin + ray_direction * 3.5
		weapon.global_position = preview_pos
		weapon.rotation_degrees = Vector3.ZERO
	else:
		var attachment_position = attachment_point.position
		var attachment_distance = attachment_position.distance_to(Vector3.ZERO)
		var direction_to_weapon = (weapon.global_position - player.global_position).normalized()
		var angle_y = atan2(direction_to_weapon.x, direction_to_weapon.z) + deg_to_rad(-180)
		weapon.rotation.y = angle_y
		weapon.global_position = collision_point_with_player
		var forward_vector = -Vector3.FORWARD.rotated(Vector3.UP, weapon.rotation.y)
		weapon.global_position -= forward_vector * attachment_distance
	
func check_if_add_weapon():
	if Input.is_action_just_pressed("left_mouse_click") and is_on_player:
		weapon.go_to_idle()
	elif Input.is_action_just_pressed("right_mouse_click") or Input.is_action_just_pressed("ui_cancel"):
		weapon.queue_free()
