extends Control

@onready var upgrade_description = $UpgradeDescription
@onready var weapon_icon = $WeaponIcon
var variant_id: int
var weapon: Weapon

func load_upgrade_data(weapon, variant_id, variant_description):
	weapon_icon.load_icon_data(weapon.weapon_name, weapon.weapon_level)
	upgrade_description.text = variant_description
	variant_id = variant_id
	

func _on_button_button_down() -> void:
	weapon.apply_upgrade(variant_id)
