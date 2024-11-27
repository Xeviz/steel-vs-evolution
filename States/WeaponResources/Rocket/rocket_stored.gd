extends State
class_name RocketStored

@export var rocket: Rocket


func enter():
	rocket.rocket_area.monitoring = false
	rocket.rocket_area.monitorable = false
	rocket.rocket_mesh.visible = false

func update(_delta):
	if rocket.is_fired == true:
		state_transition.emit(self, "RocketFired")
