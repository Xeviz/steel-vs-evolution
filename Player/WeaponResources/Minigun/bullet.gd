extends Projectile
class_name Bullet

var speed : float
var damage : int
var penetration : int
var penetrated_targets = 0
var is_fired = true
var range : float

@onready var starting_position = position
@onready var bullet_ray = $RayCast3D
@onready var bullet_area = $BulletArea
@onready var bullet_mesh = $MeshInstance3D

func connect_to_weapon(weapon):
	speed = weapon.ammo_speed 
	damage = weapon.ammo_damage
	range = weapon.ammo_range
	penetration = weapon.ammo_penetration

func _on_bullet_area_body_entered(body):
	if body is Enemy:
		penetrated_targets += 1
		body.receive_damage(damage, "bullet")
