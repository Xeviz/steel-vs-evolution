extends Weapon
class_name RocketLauncher



@onready var animation_tree = $AnimationTree
@onready var animation_state = $AnimationTree.get("parameters/playback")
@onready var reload_player = $ReloadPlayer
@export var bullet_scene: PackedScene
var base_weapon_cost = 1

var base_fire_rate: float = 0.1
var fire_rate: float = 0.1
var fire_rate_modifier: float = 1.0

var base_ammo_capacity: int = 1
var ammo_capacity: int = 1
var ammo_capacity_modifier: float = 1.0

var base_time_to_reload: float = 4.0
var time_to_reload: float = 4.0
var time_to_reload_modifier: float = 1.0
var ammo_left: int = ammo_capacity

var base_ammo_speed: float = 15.0
var ammo_speed: float = 15.0
var ammo_speed_modifier: float = 1.0

var base_ammo_damage: int = 150
var ammo_damage: int = 150
var ammo_damage_modifier: float = 1.0

var base_ammo_range: float = 15.0
var ammo_range: float = 15.0
var ammo_range_modifier: float = 1.0

var base_ammo_explosion_area: float = 4.0
var ammo_explosion_area: float = 4.0
var ammo_explosion_area_modifier: float = 1.0


var fired_bullets: Array = []
var stored_bullets: Array = []


func _ready():
	apply_menu_progression()
	weapon_name = "RocketLauncher"
	upgrade_variants = {
	1: "Increase explosion area by 10%",
	2: "Increase damage by 5%",
	3: "Decrease reload time by 10%",
	4: "Increase ammo capacity by 1"
}

func apply_menu_progression():
	ammo_damage_modifier += global_data.menu_progressions["rocket_launcher_damage"][1]*0.01
	ammo_damage = int(base_ammo_damage*ammo_damage_modifier)


func fire_bullet():
	var bullet
	if stored_bullets.size() > 0:
		bullet = stored_bullets.pop_back()
	else:
		bullet = bullet_scene.instantiate()
		bullet.stored.connect(on_bullet_stored)
		bullet.connect_to_weapon(self)
		player.current_map.add_child(bullet)
		bullet.update_explosion_size(ammo_explosion_area)
	var bullet_spawn_position = $BulletSpawner.global_transform
	bullet.global_transform = bullet_spawn_position
	bullet.is_fired = true
	bullet.audio_player.play()
	fired_bullets.append(bullet)

func on_bullet_stored(bullet):
	fired_bullets.erase(bullet)
	stored_bullets.append(bullet)
	
	
func apply_upgrade(variant_id):
	if variant_id == 1:
		upgrade_explosion_area(0.1)
	elif variant_id == 2:
		upgrade_damage(0.5)
	elif variant_id == 3:
		upgrade_time_to_reload(-0.1)
	elif variant_id == 4:
		upgrade_ammo_capacity(1)
	clear_bullets()

func clear_bullets():
	for fired_bullet in fired_bullets:
		fired_bullet.should_be_erased = true
	for stored_bullet in stored_bullets:
		stored_bullet.queue_free()
	fired_bullets.clear()
	stored_bullets.clear()

func upgrade_explosion_area(upgrade_value):
	if upgrade_value < 1 and upgrade_value > -1:
		ammo_explosion_area_modifier+=upgrade_value
	else:
		base_ammo_explosion_area+=upgrade_value
	ammo_explosion_area = base_ammo_explosion_area*ammo_explosion_area_modifier
	
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

func upgrade_ammo_capacity(upgrade_value):
	if upgrade_value < 1 and upgrade_value > -1:
		ammo_capacity_modifier+=upgrade_value
		ammo_left+=int(upgrade_value*base_ammo_capacity)
	else:
		base_ammo_capacity+=upgrade_value
		ammo_left+=upgrade_value
	ammo_capacity = int(base_ammo_capacity * ammo_capacity_modifier)

func upgrade_time_to_reload(upgrade_value):
	if upgrade_value < 1 and upgrade_value > -1:
		time_to_reload_modifier+=upgrade_value
	else:
		base_time_to_reload+=upgrade_value
	time_to_reload = base_time_to_reload*time_to_reload_modifier
