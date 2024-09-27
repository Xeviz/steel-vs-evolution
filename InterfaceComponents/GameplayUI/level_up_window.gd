extends Control

var level_up_options: Array = []
var weapon_upgrade_info = preload("res://InterfaceComponents/GameplayUI/weapon_upgrade_info.tscn")
@onready var upgrades_container = $GridContainer


func get_random_upgrades(weapons):
	
	while len(level_up_options)<4:
		var weapon = weapons.pick_random()
		var variant_id = weapon.upgrade_variants.keys().pick_random()
		while [weapon, variant_id] in level_up_options:
			variant_id = weapon.upgrade_variants.keys().pick_random()
		level_up_options.append([weapon, variant_id])
	
	for option in level_up_options:
		var new_weapon_upgrade_info = weapon_upgrade_info.instantiate()
		upgrades_container.add_child(new_weapon_upgrade_info)
		new_weapon_upgrade_info.load_upgrade_data(option[0], option[1])
		
		
func deactivate_level_up_window():
	get_parent().unpause_game()
	queue_free()
