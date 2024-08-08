extends State
class_name MinigunFiring

@export var minigun : Minigun


func update(delta: float):
	minigun.fire_timer -= delta
	if minigun.fire_timer <= 0:
		minigun.fire_bullet()
		minigun.fire_timer = minigun.fire_rate
		minigun.ammo_left -= 1
	if minigun.ammo_left <= 0:
		state_transition.emit(self, "MinigunReloading")
