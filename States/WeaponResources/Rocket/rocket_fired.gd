extends State
class_name RocketFired


@export var rocket: Rocket


func enter():
	rocket.starting_position = rocket.position
	if rocket.rocket_area:
		rocket.rocket_area.monitoring = true
		rocket.rocket_area.monitorable = true
		rocket.rocket_mesh.visible = true
	
func physics_update(delta):
	rocket.position += rocket.transform.basis * Vector3(0, 0, -rocket.speed) * delta
	if rocket.position.distance_to(rocket.starting_position) >= rocket.range:
		state_transition.emit(self, "RocketExploded")
