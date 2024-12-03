extends Projectile
class_name Rocket


var is_fired = true
var is_exploding = false
var speed : float
var damage : int
var range : float
var explosion_time : float = 2.5
var explosion
var velocity: Vector3 = Vector3.ZERO
var velocity_basis : Vector3
var should_be_erased := false


@onready var audio_player = $AudioStreamPlayer3D
@onready var explosion_player = $ExplosionPlayer

@onready var starting_position = position
@onready var rocket_ray = $RayCast3D
@onready var state_machine = $FiniteStateMachine
@onready var explosion_area = $ExplosionArea
@onready var explosion_area_border = $ExplosionArea/CollisionShape3D
@export var explosion_scene: PackedScene
@export var rocket_area: Area3D
@export var rocket_mesh: MeshInstance3D


func _ready() -> void:
	explosion = explosion_scene.instantiate()
	get_tree().current_scene.add_child(explosion)

func connect_to_weapon(weapon):
	speed = weapon.ammo_speed
	damage = weapon.ammo_damage
	range = weapon.ammo_range
	velocity_basis = transform.basis.z.normalized()
	velocity = velocity_basis * -speed
	
	
func update_explosion_size(new_size):
	explosion_area_border.shape.size = Vector3(new_size, 1.0, new_size)
	explosion.change_scale(new_size)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if is_exploding:
		return
	if body is Enemy:
		self.go_to_exploded()
	
func rocket_explosion():
	for enemy in explosion_area.get_overlapping_bodies():
		if enemy is Enemy:
			enemy.receive_damage(damage, "rocket")
			

func go_to_exploded():
	is_exploding = true
	explosion.global_position = global_position
	explosion.global_position.y = 0
	explosion.play_explosion()
	explosion_player.play()
	state_machine.on_child_transition(state_machine.current_state, "RocketExploded")
