extends State
class_name RocketLauncherFiring

@export var rocket_launcher : RocketLauncher


func update(delta: float):
	rocket_launcher.fire_timer -= delta
	if rocket_launcher.fire_timer <= 0:
		rocket_launcher.fire_bullet()
		rocket_launcher.fire_timer = rocket_launcher.fire_rate
		rocket_launcher.ammo_left -= 1
	if rocket_launcher.ammo_left <= 0:
		state_transition.emit(self, "WeaponReloading")
