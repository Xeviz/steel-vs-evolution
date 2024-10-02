extends State
class_name SpawningEnemies

@export var spawner: Node3D


func update(delta):
	if global_data.time_stopped:
		return
	spawner.global_transform.origin = spawner.player.global_transform.origin
	spawner.time_to_spawn-= delta
	if spawner.time_to_spawn <= 0 :
		spawner.get_random_position()
		spawner.time_to_spawn = 0.5
		global_data.alive_enemies+=1
		print("alive " + str(global_data.alive_enemies))
