extends Control

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("Player")
@onready var attachable_item = preload("res://InterfaceComponents/CustomizationUI/attachable_item.tscn")
@onready var chosable_item = preload("res://InterfaceComponents/CustomizationUI/chosable_item.tscn")
@onready var weapons_rect = $WeaponsRect
@onready var upper_bodies_rect = $UpperBodiesRect
@onready var lower_bodies_rect = $LowerBodiesRect
@onready var weapons_grid = $WeaponsRect/AttachableWeapons
@onready var lower_bodies_grid = $LowerBodiesRect/ChosableLowerBodies
@onready var upper_bodies_grid = $UpperBodiesRect/ChosableUpperBodies
@onready var weaponery_button = $GoToWeaponery
@onready var gameplay_button = $GoToGameplay
@onready var cp_label = $CPInfo
var current_upper_body_scene = "upper_body_part_1"


func _ready():
	cp_label.text = "Available CP: " + str(player.construction_points)
	
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
	
	open_bodies_window()
	
	
func open_weapons_window():
	lower_bodies_rect.hide()
	upper_bodies_rect.hide()
	weaponery_button.hide()
	weapons_rect.show()
	gameplay_button.show()

func open_bodies_window():
	weapons_rect.hide()
	gameplay_button.hide()
	lower_bodies_rect.show()
	upper_bodies_rect.show()
	weaponery_button.show()

func pass_item_preview(item_scene_name):
	get_parent().show_weapon_preview(item_scene_name)
	
func pass_item_choice(item_scene_name):
	if item_scene_name.begins_with("upper_body_part"):
		current_upper_body_scene = item_scene_name
	get_parent().chose_item(item_scene_name, current_upper_body_scene)


func _on_go_to_weaponery_button_down() -> void:
	open_weapons_window()


func _on_go_to_gameplay_button_down() -> void:
	get_parent().go_to_gameplay_zone()
