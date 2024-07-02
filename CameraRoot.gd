extends Node3D

@onready var yaw_node = $CameraYaw
@onready var pitch_node = $CameraYaw/CameraPitch
@onready var camera = $CameraYaw/CameraPitch/Camera3D

var player

var yaw : float = 0
var pitch : float = 0

var yaw_sensitivity : float = 0.07
var pitch_sensitivity : float = 0.07

var yaw_acceleration : float = 15
var pitch_acceleration : float = 15

var pitch_max : float = 75
var pitch_min : float = -55


# Called when the node enters the scene tree for the first time.
func _ready():
	player = $Player

	
func _input(event):
	# 
	if Input.is_action_pressed("camera_rotation_mode") and event is InputEventMouseMotion:
		yaw += event.relative.x * yaw_sensitivity
		pitch += -event.relative.y * pitch_sensitivity

func _physics_process(delta):
	pitch = clamp(pitch, pitch_min, pitch_max)
	yaw_node.rotation_degrees.y = lerp(yaw_node.rotation_degrees.y, yaw, yaw_acceleration * delta)
	pitch_node.rotation_degrees.x = lerp(pitch_node.rotation_degrees.x, pitch, pitch_acceleration * delta)
