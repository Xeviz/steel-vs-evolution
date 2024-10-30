extends State
class_name MinigunFiring

@export var minigun : Minigun
var fire_timer = 0.0

func enter():
	minigun.animation_state.travel("MinigunShooting")
	print("zaczynam strzelac")

func update(delta: float):
	fire_timer -= delta
	if fire_timer <= 0:
		minigun.fire_bullet()
		fire_timer = minigun.fire_rate
		minigun.ammo_left -= 1
	if minigun.ammo_left <= 0:
		state_transition.emit(self, "WeaponReloading")
		
func exit():
	minigun.animation_state.travel("MinigunIdle")
