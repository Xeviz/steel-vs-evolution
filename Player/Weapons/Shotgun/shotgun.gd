extends Weapon
class_name Shotgun

@export var bullet_scene: PackedScene
@onready var animation_tree = $AnimationTree
@onready var animation_state = $AnimationTree.get("parameters/playback")
var base_weapon_cost = 2

var fired_bullets: Array = []
var stored_bullets: Array = []

var base_fire_rate: float = 0.5
var fire_rate: float = 0.5
var fire_rate_modifier: float = 1.0


var base_ammo_damage: int = 120
var ammo_damage: int = 120
var ammo_damage_modifier: float = 1.0

var base_ammo_speed: float = 20.0
var ammo_speed: float = 20.0
var ammo_speed_modifier: float = 1.0

var ammo_penetration: int = 10

var base_ammo_range: float = 3.0
var ammo_range: float = 3.0
var ammo_range_modifier: float = 1.0

var base_ammo_capacity: int = 3
var ammo_capacity: int = 3
var ammo_capacity_modifier: float = 1.0
var ammo_left: int = ammo_capacity

var base_time_to_reload: float = 2.0
var time_to_reload: float = 2.0
var time_to_reload_modifier: float = 1.0

var base_spread_angle: int = 20
var spread_angle: int = 20
var spread_angle_modifier: float = 1.0

	

func _ready():
	weapon_name = "Shotgun"
	upgrade_variants = {
	1: "Increase ammo damage by 30",
	2: "Decrease reload time by 12%",
	3: "Increase ammo range by 1.0 and decrease spread angle by 8%",
	4: "Increase ammo capacity by 1",
	5: "Increase penetration by 5 and spread angle by 5%"
	
}

func fire_bullet():
	animation_state.travel("ShotgunFiring")
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
	
func apply_upgrade(variant_id):
	if variant_id == 1:
		upgrade_damage(30)
	elif variant_id == 2:
		upgrade_time_to_reload(-0.12)
	elif variant_id == 3:
		upgrade_ammo_range(1.0)
		upgrade_spread_angle(-0.08)
	elif variant_id == 4:
		upgrade_ammo_capacity(1)
	elif variant_id == 5:
		upgrade_ammo_penetration(5)
		upgrade_spread_angle(-0.05)
	stored_bullets.clear()



func upgrade_damage(upgrade_value):
	if upgrade_value < 1 and upgrade_value > -1:
		ammo_damage_modifier+=upgrade_value
	else:
		base_ammo_damage+=upgrade_value
	ammo_damage = base_ammo_damage*ammo_damage_modifier
	
func upgrade_fire_rate(upgrade_value):
	if upgrade_value < 1 and upgrade_value > -1:
		fire_rate_modifier+=upgrade_value
	else:
		base_fire_rate+=upgrade_value
	fire_rate = base_fire_rate * fire_rate_modifier
	
func upgrade_ammo_speed(upgrade_value):
	if upgrade_value < 1 and upgrade_value > -1:
		ammo_speed_modifier+=upgrade_value
	else:
		base_ammo_speed+=upgrade_value
	ammo_speed = base_ammo_speed*ammo_speed_modifier

func upgrade_ammo_penetration(upgrade_value):
	ammo_penetration+=upgrade_value
	
func upgrade_ammo_capacity(upgrade_value):
	if upgrade_value < 1 and upgrade_value > -1:
		ammo_capacity_modifier+=upgrade_value
	else:
		base_ammo_capacity+=upgrade_value
	ammo_capacity = int(base_ammo_capacity * ammo_capacity_modifier)

func upgrade_time_to_reload(upgrade_value):
	if upgrade_value < 1 and upgrade_value > -1:
		time_to_reload_modifier+=upgrade_value
	else:
		base_time_to_reload+=upgrade_value
	time_to_reload = base_time_to_reload*time_to_reload_modifier
	
	
func upgrade_ammo_range(upgrade_value):
	if upgrade_value < 1 and upgrade_value > -1:
		ammo_range_modifier+=upgrade_value
	else:
		base_ammo_range+=upgrade_value
	ammo_range = int(base_ammo_range * ammo_range_modifier)
	
func upgrade_spread_angle(upgrade_value):
	if upgrade_value < 1 and upgrade_value > -1:
		spread_angle_modifier+=upgrade_value
	else:
		base_spread_angle+=upgrade_value
	spread_angle = int(base_spread_angle * spread_angle_modifier)
