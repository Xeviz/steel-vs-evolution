extends State
class_name MinigunReloading

@export var minigun : Minigun

func update(delta: float):
	minigun.time_left_to_reload -= delta
	if minigun.time_left_to_reload <= 0:
		minigun.ammo_left = minigun.ammo_capacity
		minigun.time_left_to_reload = minigun.time_to_reload
		state_transition.emit(self, "MinigunFiring")
