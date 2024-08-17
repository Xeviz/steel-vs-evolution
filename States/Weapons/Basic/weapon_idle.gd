extends State
class_name WeaponIdle

@export var weapon: Weapon


func enter():
	if weapon.fired_bullets:
		weapon.fired_bullets.clear()
		weapon.stored_bullets.clear()
