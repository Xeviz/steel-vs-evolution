extends Weapon
class_name Shotgun

@export var bullet_scene: PackedScene
var base_weapon_cost = 2

var fire_rate: float = 0.5
var fire_timer: float = 0.0
var fired_bullets: Array = []
var stored_bullets: Array = []
var ammo_speed: float = 20.0
var ammo_damage: int = 120
var ammo_penetration: int = 10
var ammo_range: float = 3.0
var ammo_capacity: int = 3
var time_to_reload: float = 2.0
var ammo_left: int = ammo_capacity
var spread_angle: int = 20

func _ready():
	weapon_name = "Shotgun"


func fire_bullet():
	var original_transform = $BulletSpawner.transform
	var angle_increment = spread_angle * 2.0 / max(1, ammo_capacity - 1)
	var start_angle = -spread_angle-angle_increment
	var rotation_axis = Vector3(0, 1, 0)
	$BulletSpawner.transform = $BulletSpawner.transform.rotated(rotation_axis, deg_to_rad(start_angle))  
	for g in range(ammo_capacity):
		var bullet
		if stored_bullets.size() > 0:
			bullet = stored_bullets.pop_back()
			bullet.is_fired = true
		else:
			bullet = bullet_scene.instantiate()
			bullet.stored.connect(on_bullet_stored)
			bullet.connect_to_weapon(self)
			get_tree().root.add_child(bullet)
		var angle_offset = start_angle + g * angle_increment
		var rotation_amount = deg_to_rad(angle_increment)
		
		$BulletSpawner.transform = $BulletSpawner.transform.rotated(rotation_axis, rotation_amount)
		
		var spawner_transform = $BulletSpawner.global_transform
		bullet.global_transform = spawner_transform
		
		fired_bullets.append(bullet)
	$BulletSpawner.transform = original_transform

func on_bullet_stored(bullet):
	fired_bullets.erase(bullet)
	stored_bullets.append(bullet)
