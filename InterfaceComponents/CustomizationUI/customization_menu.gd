extends Control

@onready var player: CharacterBody3D
@onready var attachable_item = preload("res://InterfaceComponents/CustomizationUI/attachable_item.tscn")


func _ready():
	var minigun_item = attachable_item.instantiate()
	minigun_item.load_weapon_data("minigun")
	$AttachableWeapons.add_child(minigun_item)
	
	var shotgun_item = attachable_item.instantiate()
	shotgun_item.load_weapon_data("shotgun")
	$AttachableWeapons.add_child(shotgun_item)
	
	var chainsaw_item = attachable_item.instantiate()
	chainsaw_item.load_weapon_data("chainsaw")
	$AttachableWeapons.add_child(chainsaw_item)
	
	
	var body_part_2_item = attachable_item.instantiate()
	body_part_2_item.load_body_part_data("body_part_2")
	$AttachableParts.add_child(body_part_2_item)
	
	var body_part_4_item = attachable_item.instantiate()
	body_part_4_item.load_body_part_data("body_part_4")
	$AttachableParts.add_child(body_part_4_item)
	
	


func pass_item_preview(item_scene_name):
	get_parent().show_item_preview(item_scene_name)
