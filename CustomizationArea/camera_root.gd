extends Node3D

@onready var yaw_node = $CameraYaw
@onready var pitch_node = $CameraYaw/CameraPitch
@onready var camera = $CameraYaw/CameraPitch/SpringArm3D/Camera3D


var player

var yaw : float = 0
var pitch : float = 0

var yaw_sensitivity : float = 0.07
var pitch_sensitivity : float = 0.07

var yaw_acceleration : float = 15
var pitch_acceleration : float = 15

var pitch_max : float = 75
var pitch_min : float = -55



func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _input(event):
	if Input.is_action_pressed("camera_rotation_mode") and event is InputEventMouseMotion:
		yaw += event.relative.x * yaw_sensitivity
		pitch += -event.relative.y * pitch_sensitivity

func smooth_camera_movement(delta):
	pitch = clamp(pitch, pitch_min, pitch_max)
	yaw_node.rotation_degrees.y = lerp(yaw_node.rotation_degrees.y, yaw, yaw_acceleration * delta * 0.5)
	pitch_node.rotation_degrees.x = lerp(pitch_node.rotation_degrees.x, pitch, pitch_acceleration * delta * 0.5)

func _physics_process(delta):
	smooth_camera_movement(delta)
	if Input.is_action_just_pressed("mouse_pointer_in_creator"):
		show_weapon_preview()

func show_weapon_preview():
	print("preview_show")
	var weapon_scene = preload("res://Player/Weapons/minigun.tscn")
	var new_weapon = weapon_scene.instantiate()
	var weapon_state_machine = new_weapon.get_node("FiniteStateMachine")
	add_child(new_weapon)
	new_weapon.go_to_preview()




	#if Input.is_action_pressed("mouse_pointer_in_creator"):
		#var mouse_pos = get_viewport().get_mouse_position()
		#var ray_origin = camera.project_ray_origin(mouse_pos)
		#var ray_direction = camera.project_ray_normal(mouse_pos)
		#var ray_end = ray_origin + ray_direction * 2000
		#
		#var new_intersection = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
		#var intersection = get_world_3d().direct_space_state.intersect_ray(new_intersection)
		#
		#if intersection.size() > 0:
			#_create_placeholder_mesh(intersection.position)
#
#func _create_placeholder_mesh(mesh_position: Vector3):
	#var mesh_instance = MeshInstance3D.new()
	#var mesh = BoxMesh.new()
	#mesh.size = Vector3(0.3, 0.3, 1)
	#mesh_instance.mesh = mesh
	#mesh_instance.transform.origin = mesh_position  # Set the position of the mesh instance
	#
	#mesh_instance.look_at(camera.global_transform.origin)
	#mesh_instance.rotate_object_local(Vector3.UP, PI)
	#
	#player.add_child(mesh_instance)
