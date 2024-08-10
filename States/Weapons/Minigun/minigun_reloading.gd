extends State
class_name MinigunReloading

@export var weapon : Weapon
var time_to_reload: float

func enter():
	time_to_reload = weapon.time_to_reload

func update(delta: float):
	time_to_reload -= delta
	if time_to_reload <= 0:
		weapon.ammo_left = weapon.ammo_capacity
		state_transition.emit(self, "MinigunFiring")
