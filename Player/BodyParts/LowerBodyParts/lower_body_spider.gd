extends Node3D


@onready var model = $Armature
@onready var lower_collider_area = $LowerBodyPlayer
@onready var lower_body_collision_shape = $LowerBodyPlayer/LowerBodyCollision
@onready var attachment_point: Node3D = $AttachmentPoint
@onready var upper_collider_area: StaticBody3D
@export var ground_offset: float = 0.5

@onready var fl_leg = $FrontLeftIKTarget
@onready var fr_leg = $FrontRightIKTarget

@onready var bl_leg = $BackLeftIKTarget
@onready var br_leg = $BackRightIKTarget

var speed: float = 5.0
var turn_speed: float = 1.0
var is_idle = true
var player : CharacterBody3D

func _ready() -> void:
	var default_upper_scene = preload("res://Player/BodyParts/UpperBodyParts/upper_body_part_1.tscn")
	player = get_parent()
	upper_collider_area = default_upper_scene.instantiate()
	add_child(upper_collider_area)
	offset_upper_body()


func change_upper_body(upper_body_scene):
	remove_child(upper_collider_area)
	upper_collider_area = upper_body_scene.instantiate()
	upper_collider_area.position = attachment_point.position
	add_child(upper_collider_area)
	offset_upper_body()
	
	
func offset_upper_body():
	var upper_attachment_point = upper_collider_area.attachment_point.global_transform.origin
	var self_attachment_point = attachment_point.global_transform.origin
	var offset = self_attachment_point - upper_attachment_point
	upper_collider_area.global_transform.origin += offset
	
func disable_colliders():
	lower_collider_area.set_collision_layer_value(1, false)
	lower_collider_area.set_collision_mask_value(1, false)
	
	upper_collider_area.set_collision_layer_value(1, false)
	upper_collider_area.set_collision_mask_value(1, false)
	
func _process(delta):
	var plane1 = Plane(bl_leg.global_position, fl_leg.global_position, fr_leg.global_position)
	var plane2 = Plane(fr_leg.global_position, br_leg.global_position, bl_leg.global_position)
	var avg_normal = ((plane1.normal + plane2.normal) / 2).normalized()
	
	var target_basis = _basis_from_normal(avg_normal)
	transform.basis = lerp(transform.basis, target_basis, speed * delta).orthonormalized()
	
	var avg = (fl_leg.position + fr_leg.position + bl_leg.position + br_leg.position) / 4
	var target_pos = avg + transform.basis.y * ground_offset
	var distance = transform.basis.y.dot(target_pos - position)
	position = lerp(position, position + transform.basis.y * distance, speed * delta)
	
	_handle_movement(delta)
	
func _handle_movement(delta):
	var dir = Input.get_axis('ui_down', 'ui_up')
	var movement = Vector3(0, 0, -dir) * speed * delta
	translate(Vector3(0, 0, -dir) * speed * delta)
	
	var a_dir = Input.get_axis('ui_right', 'ui_left')
	rotate_object_local(Vector3.UP, a_dir * turn_speed * delta)
	
	var player_position = player.position
	player_position += transform.basis.x * movement.x + transform.basis.z * movement.z
	player_position.y = player.position.y 
	player.position = player_position

func _basis_from_normal(normal: Vector3) -> Basis:
	var result = Basis()
	result.x = normal.cross(transform.basis.z)
	result.y = normal
	result.z = transform.basis.x.cross(normal)

	result = result.orthonormalized()
	result.x *= scale.x 
	result.y *= scale.y 
	result.z *= scale.z 
	
	return result
