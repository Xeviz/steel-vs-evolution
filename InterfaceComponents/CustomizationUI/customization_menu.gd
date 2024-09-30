extends Control

@onready var player: CharacterBody3D
@onready var attachable_item = preload("res://InterfaceComponents/CustomizationUI/attachable_item.tscn")
@onready var chosable_item = preload("res://InterfaceComponents/CustomizationUI/chosable_item.tscn")
@onready var weapons_grid = $AttachableWeapons
@onready var lower_bodies_grid = $ChosableLowerBodies
@onready var upper_bodies_grid = $ChosableUpperBodies

func _ready():
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
	lower_bodies_grid.hide()
	upper_bodies_grid.hide()
	weapons_grid.show()

func open_bodies_window():
	weapons_grid.hide()
	lower_bodies_grid.show()
	upper_bodies_grid.show()

func pass_item_preview(item_scene_name):
	get_parent().show_weapon_preview(item_scene_name)
	
func pass_item_choice(item_scene_name):
	get_parent().chose_item(item_scene_name)
