extends Weapon
class_name Minigun

@export var bullet_scene: PackedScene
var base_weapon_cost = 1

var fire_rate: float = 0.15
var fire_timer: float = 0.0
var ammo_capacity: int = 40
var time_to_reload: float = 2.0
var ammo_left: int = ammo_capacity

var ammo_speed: float = 5.0
var ammo_damage: int = 50
var ammo_penetration: int = 2
var ammo_range: float = 15.0

var fired_bullets: Array = []
var stored_bullets: Array = []



func _ready():
	weapon_name = "Minigun"


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
