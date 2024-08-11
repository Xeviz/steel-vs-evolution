extends CharacterBody3D


@export var weapons: Node3D
var SPEED = 250
var is_on_the_map = false
var game_map
var camera
var params = PhysicsRayQueryParameters3D.new()



	
func _enter_tree():
	game_map = get_parent()
	camera = game_map.get_node("PlayerFollowingCamera")
	var all_weapons = weapons.get_children()
	for weapon in all_weapons:
		print(weapon.weapon_name)


func move_player(delta: float):
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_backward")
	
	if input.length() > 0:
		input = input.normalized()
	
	velocity = input * SPEED * delta
	move_and_slide()


func look_at_mouse():
	var mouse_position = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_position)
	var ray_direction = camera.project_ray_normal(mouse_position)
	var ray_end = ray_origin + ray_direction * 2000.0  
	
	var space_state = get_world_3d().direct_space_state
	params.from = ray_origin
	params.to = ray_end
	var result = space_state.intersect_ray(params)
	
	if result:
		var look_at_position = result.position
		look_at_position.y = global_transform.origin.y 
		
		var direction = look_at_position - global_transform.origin
		rotation_degrees.y = atan2(direction.x, direction.z) * rad_to_deg(1.0)
		
