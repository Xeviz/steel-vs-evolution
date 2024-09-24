extends State
class_name WeaponIdle

@export var weapon: Weapon


func enter():
	if weapon is not MeleeWeapon:
		print(weapon)
		weapon.fired_bullets.clear()
		weapon.stored_bullets.clear()
