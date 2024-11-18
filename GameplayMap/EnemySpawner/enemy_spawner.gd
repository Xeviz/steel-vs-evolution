extends Node3D

@export var current_enemy: PackedScene
@export var current_boss: PackedScene
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var gameplay_world = get_parent()

@onready var up_sector = $SpawnSectors/Up
@onready var down_sector = $SpawnSectors/Down
@onready var left_sector = $SpawnSectors/Left
@onready var right_sector = $SpawnSectors/Right

var is_spawning = true
var time_to_spawn = 1.5
var spawn_directions = ["up", "down", "left", "right"]
var offsets_directions = [1, -1]
var current_recipe = {"speed": 120, "health": 50, "experience": 3, "damage": 7}
var current_boss_recipe = {"speed": 120, "health": 500, "experience": 0, "damage": 35}

func get_random_position(base_offset):
	var offset = base_offset * randf_range(1.1, 1.5) * offsets_directions.pick_random()
	var spawn_sector = spawn_directions.pick_random()
	var new_position: Vector3
	match spawn_sector:
		"up":
			new_position = Vector3(up_sector.global_position.x + offset, 0, up_sector.global_position.z)
		"down":
			new_position = Vector3(down_sector.global_position.x + offset, 0, down_sector.global_position.z)
		"left":
			new_position = Vector3(left_sector.global_position.x, 0, left_sector.global_position.z + offset)
		"right":
			new_position = Vector3(right_sector.global_position.x, 0, right_sector.global_position.z + offset)
	return new_position

func spawn_regular_enemy():
	global_data.amount_of_enemies_spawned+=1
	var new_enemy = current_enemy.instantiate()
	new_enemy.set_stats_from_recipe(current_recipe)
	new_enemy.global_position = get_random_position(5)
	gameplay_world.add_child(new_enemy)
	
func spawn_boss():
	global_data.amount_of_enemies_spawned+=1
	var new_enemy = current_boss.instantiate()
	new_enemy.set_stats_from_recipe(current_boss_recipe)
	new_enemy.global_position = get_random_position(8)
	gameplay_world.add_child(new_enemy)
