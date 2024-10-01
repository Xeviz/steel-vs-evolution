extends CharacterBody3D
class_name Player


@export var weapons: Node3D
@export var lower_body: Node3D
@onready var state_machine = $FiniteStateMachine
var params = PhysicsRayQueryParameters3D.new()
var is_on_the_map = false
var current_map
var camera

var construction_points: int = 1
var level: int = 1
var experience: int = 0
var experience_to_level_up: int = 20
var next_required_exp: int = 10

var speed: int = 250
var max_health: int = 150
var health: int = 120


func change_lower_body(lower_body_scene):
	remove_child(lower_body)
	var previous_upper_body = lower_body.upper_collider_area
	lower_body = lower_body_scene.instantiate()
	add_child(lower_body)

func apply_menu_upgrades():
	pass


func _enter_tree():
	current_map = get_parent()
	if current_map is GameplayMap:
		camera = current_map.get_node("PlayerFollowingCamera")


func move_player(delta: float):
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_backward")
	
	if input.length() > 0 and lower_body.is_idle:
		lower_body.go_to_walking()
		input = input.normalized()
	elif input.length() > 0:
		input = input.normalized()
	else:
		lower_body.go_to_idle()
	

	velocity = input * speed * delta
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
		
func go_to_gameplay_state():
	state_machine.on_child_transition(state_machine.current_state, "GameplayMode")

func go_to_customization_state():
	state_machine.on_child_transition(state_machine.current_state, "CustomizationMode")
	
func get_player():
	get_tree().current_scene.player = get_tree().get_first_node_in_group("Player")
	transform.basis = Basis()
	global_position.x = 0
	global_position.z = 0
		
func get_experience(amount):
	experience+=amount
	while experience>=experience_to_level_up:
		level += 1
		experience -= experience_to_level_up
		experience_to_level_up += next_required_exp
		next_required_exp+=5
		get_parent().activate_level_up_window()
