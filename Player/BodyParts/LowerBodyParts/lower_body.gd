extends Node3D


@onready var model = $Armature
@onready var animation_tree = $AnimationTree
@onready var animation_state = $AnimationTree.get("parameters/playback")
@onready var lower_collider_area = $LowerBodyPlayer
@onready var lower_body_collision_shape = $LowerBodyPlayer/LowerBodyCollision
@onready var attachment_point: Node3D = $AttachmentPoint
@onready var upper_body: StaticBody3D
var is_idle = true

func _ready() -> void:
	var default_upper_scene = preload("res://Player/BodyParts/UpperBodyParts/upper_body_part_1.tscn")
	upper_body = default_upper_scene.instantiate()
	add_child(upper_body)
	offset_upper_body()

func go_to_idle():
	animation_state.travel("IdleNLA")
	is_idle = true
	
func go_to_walking():
	animation_state.travel("WalkingNLA")
	is_idle = false

func change_upper_body(upper_body_scene):
	remove_child(upper_body)
	upper_body = upper_body_scene.instantiate()
	upper_body.position = attachment_point.position
	add_child(upper_body)
	offset_upper_body()
	
	
func offset_upper_body():
	var upper_attachment_point = upper_body.attachment_point.global_transform.origin
	var self_attachment_point = attachment_point.global_transform.origin
	var offset = self_attachment_point - upper_attachment_point
	upper_body.global_transform.origin += offset
	
func disable_colliders():
	lower_collider_area.set_collision_layer_value(1, false)
	lower_collider_area.set_collision_mask_value(1, false)
	
	upper_body.set_collision_layer_value(1, false)
	upper_body.set_collision_mask_value(1, false)
	
func enable_colliders():
	lower_collider_area.set_collision_layer_value(1, true)
	lower_collider_area.set_collision_mask_value(1, true)
	
	upper_body.set_collision_layer_value(1, true)
	upper_body.set_collision_mask_value(1, true)
