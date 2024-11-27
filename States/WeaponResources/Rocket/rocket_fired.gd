extends State
class_name RocketFired


@export var rocket: Rocket


func enter():
	rocket.starting_position = rocket.global_position
	rocket.rocket_area.monitoring = true
	rocket.rocket_area.monitorable = true
	rocket.rocket_mesh.visible = true
		
func physics_update(delta):
	rocket.translate(rocket.velocity * delta)
	if rocket.global_position.distance_to(rocket.starting_position) >= rocket.range:
		rocket.go_to_exploded()
