extends TextureRect
class_name WeaponIcon


func load_icon_data(weapon_name, weapon_level = 0,):
	texture = load(global_data.weapons_icons_paths[weapon_name])
	$Label.text = "Lv. " + str(weapon_level)
	
func update_label(new_level):
	$Label.text = "Lv. " + str(new_level)
