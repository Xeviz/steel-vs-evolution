extends Weapon
class_name Minigun

@export var bullet_scene: PackedScene
var base_weapon_cost = 1

var fire_rate: float = 0.15
var fire_rate_modifier: float = 1.0
var fire_timer: float = 0.0

var ammo_capacity: int = 100
var ammo_capacity_modifier: float = 1.0
var ammo_left: int = ammo_capacity

var time_to_reload: float = 2.0
var time_to_reload_modifier: float = 1.0

var ammo_speed: float = 5.0
var ammo_speed_modifier: float = 1.0

var ammo_damage: int = 10
var ammo_damage_modifier: float = 1.0

var ammo_penetration: int = 2
var ammo_range: float = 15.0
var ammo_range_modifier: float = 1.0

var fired_bullets: Array = []
var stored_bullets: Array = []



func _ready():
	weapon_name = "Minigun"
	upgrade_variants = {
	1: "Increase fire rate by 10% and ammo capacity by 25",
	2: "Increase damage by 10",
	3: "Increase ammo speed by 10% and penetration by 1",
	4: "Increase damage by 7 and decrease reload time by 10%"
}


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


func apply_upgrade(variant_id):
	if variant_id == 1:
		upgrade_fire_rate(0.10)
		upgrade_ammo_capacity(25)
	elif variant_id == 2:
		upgrade_damage(10)
	elif variant_id == 3:
		upgrade_ammo_speed(0.10)
		upgrade_ammo_penetration(1)
	elif variant_id == 4:
		upgrade_damage(7)
		upgrade_time_to_reload(-0.10)

func upgrade_damage(upgrade_value):
	if -1 < upgrade_value < 1:
		ammo_damage_modifier+=ammo_damage
	else:
		ammo_damage+=upgrade_value
	
func upgrade_fire_rate(upgrade_value):
	if -1 < upgrade_value < 1:
		fire_rate_modifier+=upgrade_value
	else:
		fire_rate+=upgrade_value
	
func upgrade_ammo_speed(upgrade_value):
	if -1 < upgrade_value < 1:
		ammo_speed_modifier+=upgrade_value
	else:
		ammo_speed+=upgrade_value

func upgrade_ammo_penetration(upgrade_value):
	ammo_penetration+=upgrade_value
	
func upgrade_ammo_capacity(upgrade_value):
	if -1 < upgrade_value < 1:
		ammo_capacity_modifier+=upgrade_value
	else:
		ammo_capacity+=upgrade_value

func upgrade_time_to_reload(upgrade_value):
	if -1 < upgrade_value < 1:
		time_to_reload_modifier+=upgrade_value
	else:
		time_to_reload+=upgrade_value
		
