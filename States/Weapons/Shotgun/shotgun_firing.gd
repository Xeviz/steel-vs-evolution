extends State
class_name ShotgunFiring

@export var shotgun : Shotgun


func update(delta: float):
	shotgun.fire_timer -= delta
	if shotgun.fire_timer <= 0:
		shotgun.fire_bullet()
		shotgun.fire_timer = shotgun.fire_rate
		shotgun.ammo_left -= shotgun.ammo_capacity
	if shotgun.ammo_left <= 0:
		state_transition.emit(self, "WeaponReloading")
