extends CharacterBody3D

var SPEED = 250
@onready var game_map = get_parent()
@onready var camera
var params = PhysicsRayQueryParameters3D.new()


func _ready():
	camera = game_map.get_node("PlayerFollowingCamera")


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
		
