extends State
class_name SpawningEnemies

@export var spawner: Node3D


func update(delta):
	if global_data.time_to_spawn_boss:
		global_data.time_to_spawn_boss = false
		spawner.spawn_boss()
	if global_data.stop_spawning_enemies:
		return
	
	
	spawner.global_transform.origin = spawner.player.global_transform.origin
	spawner.time_to_spawn-= delta
	if global_data.amount_of_enemies_spawned < global_data.minimum_amount_of_enemies:
		spawner.time_to_spawn-=0.45
	elif global_data.amount_of_enemies_spawned >= global_data.maximum_amount_of_enemies:
		return
	if spawner.time_to_spawn <= 0:
		spawner.spawn_regular_enemy()
		spawner.time_to_spawn = 0.5
