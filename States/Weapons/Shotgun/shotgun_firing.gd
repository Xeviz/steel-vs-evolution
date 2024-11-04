extends State
class_name ShotgunFiring

@export var shotgun : Shotgun
var fire_timer = 0.0


func update(delta: float):
	fire_timer -= delta
	if fire_timer <= 0:
		shotgun.fire_bullet()
		fire_timer = shotgun.fire_rate
		shotgun.ammo_left -= shotgun.ammo_capacity
	if shotgun.ammo_left <= 0:
		state_transition.emit(self, "WeaponReloading")
