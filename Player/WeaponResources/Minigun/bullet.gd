extends Projectile
class_name Bullet

var speed : float
var damage : int
var penetration : int
var penetrated_targets = 0
var is_fired = true
var range : float
var velocity: Vector3 = Vector3.ZERO


@export var penetration_player : PackedScene
@onready var audio_player = $AudioStreamPlayer3D
@onready var starting_position = position
@onready var bullet_ray = $RayCast3D
@onready var bullet_area = $BulletArea
@onready var bullet_mesh = $MeshInstance3D

func connect_to_weapon(weapon):
	speed = weapon.ammo_speed 
	damage = weapon.ammo_damage
	range = weapon.ammo_range
	penetration = weapon.ammo_penetration
	velocity = transform.basis.z.normalized() * -speed


func _on_bullet_area_body_entered(body):
	if body is Enemy:
		if penetrated_targets == 0:
			var penetration_sound = penetration_player.instantiate()
			penetration_sound.global_position = global_position
			get_tree().root.add_child(penetration_sound)
		penetrated_targets += 1
		body.receive_damage(damage, "bullet")
