extends Projectile
class_name Rocket


var is_fired = true
var speed : float
var damage : int
var range : float
var explosion_time : float = 2.5

@onready var starting_position = position
@onready var rocket_ray = $RayCast3D
@onready var rocket_area = $Area3D
@onready var rocket_mesh = $MeshInstance3D
@onready var state_machine = $FiniteStateMachine
@onready var explosion_area = $ExplosionArea
@onready var explosion_area_border = $ExplosionArea/CollisionShape3D


func connect_to_weapon(weapon):
	speed = weapon.ammo_speed
	damage = weapon.ammo_damage
	range = weapon.ammo_range
	
	
func update_explosion_size(new_size):
	explosion_area_border.shape.size = Vector3(new_size, 1.0, new_size)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Enemy:
		self.go_to_exploded()
		self.rocket_explosion()
	
func rocket_explosion():
	for enemy in explosion_area.get_overlapping_bodies():
		if enemy is Enemy:
			enemy.receive_damage(damage, "rocket")
			

func go_to_exploded():
	state_machine.on_child_transition(state_machine.current_state, "RocketExploded")
