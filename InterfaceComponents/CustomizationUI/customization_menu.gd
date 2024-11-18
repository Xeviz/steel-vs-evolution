extends Control

@onready var player: Player = get_tree().get_first_node_in_group("Player")
@onready var attachable_item = preload("res://InterfaceComponents/CustomizationUI/attachable_item.tscn")
@onready var chosable_item = preload("res://InterfaceComponents/CustomizationUI/chosable_item.tscn")
@onready var weapon_icon = preload("res://InterfaceComponents/GameplayUI/weapon_icon.tscn")
@onready var weapons_rect = $WeaponsRect
@onready var upper_bodies_rect = $UpperBodiesRect
@onready var lower_bodies_rect = $LowerBodiesRect
@onready var weapons_grid = $WeaponsRect/AttachableWeapons
@onready var lower_bodies_grid = $LowerBodiesRect/ChosableLowerBodies
@onready var upper_bodies_grid = $UpperBodiesRect/ChosableUpperBodies
@onready var weaponery_button = $GoToWeaponery
@onready var gameplay_button = $GoToGameplay
@onready var cp_label = $CPInfo
@onready var weapon_label = $WeaponsInfo
@onready var health_label = $HealthInfo
@onready var speed_label = $SpeedInfo

@onready var player_weapons_rect = $PlayerWeaponsRect
@onready var player_weapons_grid = $PlayerWeaponsRect/PlayerWeapons

var current_upper_body_scene = "upper_body_part_1"
var current_lower_body_scene = "lower_body_part_1"


func _ready():
	cp_label.text = "Available CP: " + str(global_data.construction_points)
	
	var minigun_item = attachable_item.instantiate()
	minigun_item.load_weapon_data("minigun")
	weapons_grid.add_child(minigun_item)
	
	var shotgun_item = attachable_item.instantiate()
	shotgun_item.load_weapon_data("shotgun")
	weapons_grid.add_child(shotgun_item)
	
	var chainsaw_item = attachable_item.instantiate()
	chainsaw_item.load_weapon_data("chainsaw")
	weapons_grid.add_child(chainsaw_item)
	
	var rocket_launcher_item = attachable_item.instantiate()
	rocket_launcher_item.load_weapon_data("rocket_launcher")
	weapons_grid.add_child(rocket_launcher_item)
	
	var upper_body_part_1_item = chosable_item.instantiate()
	upper_body_part_1_item.load_upper_body_part_data("upper_body_part_1")
	upper_bodies_grid.add_child(upper_body_part_1_item)
	
	var upper_body_part_2_item = chosable_item.instantiate()
	upper_body_part_2_item.load_upper_body_part_data("upper_body_part_2")
	upper_bodies_grid.add_child(upper_body_part_2_item)
	
	var lower_body_part_1_item = chosable_item.instantiate()
	lower_body_part_1_item.load_lower_body_part_data("lower_body_part_1")
	lower_bodies_grid.add_child(lower_body_part_1_item)
	
	var lower_body_part_2_item = chosable_item.instantiate()
	lower_body_part_2_item.load_lower_body_part_data("lower_body_part_2")
	lower_bodies_grid.add_child(lower_body_part_2_item)
	
	var lower_body_part_3_item = chosable_item.instantiate()
	lower_body_part_3_item.load_lower_body_part_data("lower_body_part_3")
	lower_bodies_grid.add_child(lower_body_part_3_item)
	
	if global_data.minutes==0:
		open_bodies_window()
	else:
		open_weapons_window()
	update_health_label()
	update_speed_label()
	
	
func open_weapons_window():
	lower_bodies_rect.hide()
	upper_bodies_rect.hide()
	weaponery_button.hide()
	weapon_label.show()
	weapons_rect.show()
	gameplay_button.show()
	player_weapons_rect.show()
	
	reload_player_weapons()

func open_bodies_window():
	weapons_rect.hide()
	gameplay_button.hide()
	player_weapons_rect.hide()
	weapon_label.hide()
	lower_bodies_rect.show()
	upper_bodies_rect.show()
	weaponery_button.show()
	
func reload_player_weapons():
	for node in player_weapons_grid.get_children():
		player_weapons_grid.remove_child(node)
		node.queue_free()

	for weapon in player.weapons.get_children():
		var new_weapon_icon = weapon_icon.instantiate()
		new_weapon_icon.load_icon_data(weapon.weapon_name, weapon.weapon_level)
		weapon.icon_refference = new_weapon_icon
		player_weapons_grid.add_child(new_weapon_icon)
	pass
	
func pass_item_preview(item_scene_name):
	cp_label.text = "Available CP: " + str(global_data.construction_points)
	get_parent().show_weapon_preview(item_scene_name)
	
func pass_item_choice(item_scene_name):
	if item_scene_name.begins_with("upper_body_part"):
		current_upper_body_scene = item_scene_name
	elif item_scene_name.begins_with("lower_body_part"):
		current_lower_body_scene = item_scene_name
	get_parent().chose_item(item_scene_name, current_upper_body_scene)
	
	update_health_label()
	update_speed_label()

func update_health_label():
	var displayed_health = global_data.base_max_health 
	displayed_health += global_data.lower_bodies_stats[current_lower_body_scene]["base_health_bonus"]
	displayed_health += global_data.upper_bodies_stats[current_upper_body_scene]["base_health_bonus"]
	health_label.text = "HEALTH: " + str(displayed_health)
	
func update_speed_label():
	var displayed_speed = global_data.base_speed
	displayed_speed += global_data.lower_bodies_stats[current_lower_body_scene]["base_speed_bonus"]
	displayed_speed += global_data.upper_bodies_stats[current_upper_body_scene]["base_speed_bonus"]
	displayed_speed /= 10.0
	speed_label.text = "SPEED: " + str(displayed_speed) + " km/h"

func _on_go_to_weaponery_button_down() -> void:
	player.apply_body_parts_bonuses()
	open_weapons_window()


func _on_go_to_gameplay_button_down() -> void:
	get_parent().go_to_gameplay_zone()
