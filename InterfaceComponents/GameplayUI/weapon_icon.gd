extends TextureRect
class_name WeaponIcon

@onready var label = $Label


func load_icon_data(weapon_name, weapon_level = 0):
	texture = load(global_data.weapons_icons_paths[weapon_name])
	$Label.text = "Lv. " + str(weapon_level)
