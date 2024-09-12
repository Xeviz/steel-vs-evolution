extends Node3D

@export var spawns: Array[SpawnInfo] = []
@export var current_enemy: PackedScene
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
var current_recipe = {"speed": 120, "health": 10, "experience": 3}


func get_random_position():
	var offset = 5 * randf_range(1.1, 1.5) * offsets_directions.pick_random()
	var spawn_sector = spawn_directions.pick_random()
	var new_position: Vector3
	match spawn_sector:
		"up":
			new_position = Vector3(up_sector.global_position.x + offset, 1, up_sector.global_position.z)
		"down":
			new_position = Vector3(down_sector.global_position.x + offset, 1, down_sector.global_position.z)
		"left":
			new_position = Vector3(left_sector.global_position.x, 1, left_sector.global_position.z + offset)
		"right":
			new_position = Vector3(right_sector.global_position.x, 1, right_sector.global_position.z + offset)
	var new_enemy = current_enemy.instantiate()
	new_enemy.set_stats_from_recipe(current_recipe)
	new_enemy.global_position = new_position
	gameplay_world.add_child(new_enemy)
	
