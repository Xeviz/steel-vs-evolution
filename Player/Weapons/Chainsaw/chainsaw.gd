extends MeleeWeapon
class_name Chainsaw


@onready var cut_interval: float = 0.1
@onready var cut_damage = 10
@onready var damage_area = $DamageArea

func _ready() -> void:
	weapon_name = "Chainsaw"


func deal_damage_in_area():
	for enemy in damage_area.get_overlapping_bodies():
		if enemy is Enemy:
			enemy.receive_damage(cut_damage, "blade")
