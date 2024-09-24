extends Projectile
class_name Rocket

var speed : float
var damage : int
var is_fired = true
var range : float
var explosion_size : float
var explosion_time : float = 2.5

@onready var starting_position = position
@onready var rocket_ray = $RayCast3D
@onready var rocket_area = $Area3D
@onready var rocket_mesh = $MeshInstance3D

@onready var state_machine = $FiniteStateMachine


func connect_to_weapon(weapon):
	speed = weapon.ammo_speed
	damage = weapon.ammo_damage
	range = weapon.ammo_range
	explosion_size = weapon.ammo_explosion_size
	

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Enemy:
		self.go_to_exploded()
		self.rocket_explosion()
	
func rocket_explosion():
	for enemy in $ExplosionArea.get_overlapping_bodies():
		if enemy is Enemy:
			enemy.receive_damage(damage, "rocket")
			

func go_to_exploded():
	state_machine.on_child_transition(state_machine.current_state, "RocketExploded")
