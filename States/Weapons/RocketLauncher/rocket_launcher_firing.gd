extends State
class_name RocketLauncherFiring

@export var rocket_launcher : RocketLauncher
var fire_timer = 0.0

func enter():
	rocket_launcher.animation_state.travel("LauncherFiring")

func update(delta: float):
	fire_timer -= delta
	if fire_timer <= 0:
		rocket_launcher.fire_bullet()
		fire_timer = rocket_launcher.fire_rate
		rocket_launcher.ammo_left -= 1
	if rocket_launcher.ammo_left <= 0:
		state_transition.emit(self, "WeaponReloading")
