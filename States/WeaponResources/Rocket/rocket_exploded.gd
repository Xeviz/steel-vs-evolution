extends State
class_name RocketExploded

@export var rocket: Rocket
@onready var explosion_time = rocket.explosion_time

func enter():
	rocket.rocket_area.monitoring = false
	rocket.rocket_area.monitorable = false
	rocket.rocket_mesh.visible = false
	rocket.is_fired = false
	rocket.rocket_explosion()

func update(delta):
	explosion_time -= delta
	if explosion_time<0:
		if not rocket.should_be_erased:
			rocket.stored.emit(rocket)
			state_transition.emit(self, "RocketStored")
		else:
			rocket.queue_free()
	
func exit():
	rocket.is_exploding = false
