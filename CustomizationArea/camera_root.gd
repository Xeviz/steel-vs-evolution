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



