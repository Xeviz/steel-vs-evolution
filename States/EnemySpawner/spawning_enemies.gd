extends State
class_name SpawningEnemies

@export var spawner: Node3D


func update(delta):
	spawner.global_transform.origin = spawner.player.global_transform.origin
	spawner.time_to_spawn-= delta
	if spawner.time_to_spawn <= 0 :
		spawner.get_random_position()
		spawner.time_to_spawn = 0.5
