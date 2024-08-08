extends Weapon
class_name Minigun

@export var bullet_scene: PackedScene

var fire_rate: float = 0.15
var fired_bullets: Array = []
var stored_bullets: Array = []
var fire_timer: float = 0.0
var ammo_speed: float = 5.0
var ammo_damage: int = 50
var ammo_penetration = 1
var ammo_capacity : int = 40
var time_to_reload : float = 2.0
var time_left_to_reload = time_to_reload
var ammo_left = ammo_capacity


func fire_bullet():
	var bullet
	if stored_bullets.size() > 0:
		bullet = stored_bullets.pop_back()
		bullet.is_fired = true
	else:
		bullet = bullet_scene.instantiate()
		bullet.stored.connect(on_bullet_stored)
		bullet.connect_to_weapon(self)
		get_tree().root.add_child(bullet)

	var spawner_transform = $BulletSpawner.global_transform
	bullet.global_transform = spawner_transform
	fired_bullets.append(bullet)

func on_bullet_stored(bullet):
	fired_bullets.erase(bullet)
	stored_bullets.append(bullet)
