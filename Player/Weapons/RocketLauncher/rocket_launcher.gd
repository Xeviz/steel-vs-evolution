extends Weapon
class_name RocketLauncher

@export var bullet_scene: PackedScene
var base_weapon_cost = 1

var fire_rate: float = 4
var fire_timer: float = 0.0
var ammo_capacity: int = 1
var time_to_reload: float = 0.5
var ammo_left: int = ammo_capacity

var ammo_speed: float = 7.0
var ammo_damage: int = 150
var ammo_range: float = 15.0
var ammo_explosion_size: float = 2.0

var fired_bullets: Array = []
var stored_bullets: Array = []


func _ready():
	weapon_name = "RocketLauncher"


func fire_bullet():
	var bullet
	if stored_bullets.size() > 0:
		bullet = stored_bullets.pop_back()
		bullet.is_fired = true
	else:
		bullet = bullet_scene.instantiate()
		bullet.stored.connect(on_bullet_stored)
		bullet.connect_to_weapon(self)
		get_tree().current_scene.add_child(bullet)
	var bullet_spawn_position = $BulletSpawner.global_transform
	bullet.global_transform = bullet_spawn_position
	fired_bullets.append(bullet)

func on_bullet_stored(bullet):
	fired_bullets.erase(bullet)
	stored_bullets.append(bullet)
