extends Control

@onready var level_up_options = []
@onready var weapon_upgrade_info = preload("res://InterfaceComponents/GameplayUI/weapon_upgrade_info.tscn")



func get_random_options(weapons: Array[Weapon]):
	
	while len(level_up_options)<4:
		var weapon = weapons.pick_random()
		var variant_id = weapon.upgrade_variants.pick_random()
		while [weapon, variant_id] in level_up_options:
			variant_id = weapon.upgrade_variants.pick_random()
		level_up_options.append([weapon, variant_id])
	
	for option in level_up_options:
		var new_weapon_upgrade_info = weapon_upgrade_info.instantiate()
		
