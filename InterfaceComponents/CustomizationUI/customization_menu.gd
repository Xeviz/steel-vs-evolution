extends Control

@onready var player: CharacterBody3D
@onready var attachable_item = preload("res://InterfaceComponents/CustomizationUI/attachable_item.tscn")


func _ready():
	var minigun_item = attachable_item.instantiate()
	minigun_item.load_item_data("minigun")
	$AttachableWeapons.add_child(minigun_item)
	
	var shotgun_item = attachable_item.instantiate()
	shotgun_item.load_item_data("shotgun")
	$AttachableWeapons.add_child(shotgun_item)
	


func pass_weapon_preview(weapon_scene):
	get_parent().show_weapon_preview(weapon_scene)


