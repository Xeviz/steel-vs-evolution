extends Control

@onready var upgrade_description = $UpgradeDescription
@onready var weapon_icon = $WeaponIcon
var variant_id: int
var weapon: Weapon

func load_upgrade_data(weapon, variant_id):
	weapon_icon.load_icon_data(weapon.weapon_name, weapon.weapon_level)
	upgrade_description.text = weapon.upgrade_variants[variant_id]
	self.variant_id = variant_id
	self.weapon = weapon
	

func _on_button_button_down() -> void:
	weapon.apply_upgrade(variant_id)
	weapon.weapon_level+=1
	weapon.icon_refference.update_label(weapon.weapon_level)
	get_parent().get_parent().deactivate_level_up_window()
