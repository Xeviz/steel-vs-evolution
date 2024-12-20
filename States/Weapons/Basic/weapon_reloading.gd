extends State
class_name WeaponReloading

@export var weapon : Weapon
var time_to_reload: float

func enter():
	weapon.reload_player.play()
	weapon.animation_state.travel("WeaponReloading")
	time_to_reload = weapon.time_to_reload

func update(delta: float):
	time_to_reload -= delta
	if time_to_reload <= 0:
		weapon.ammo_left = weapon.ammo_capacity
		state_transition.emit(self, str(weapon.weapon_name + "Firing"))
