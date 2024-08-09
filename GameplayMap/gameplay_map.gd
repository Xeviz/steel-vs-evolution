extends Node3D

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("Player")
@export var map_floor: Node3D
var dif_z: float
var dif_x: float


func _process(delta):
	_check_if_slide_map()
	
func _check_if_slide_map():
	dif_x = player.position.x - map_floor.position.x
	dif_z = player.position.z - map_floor.position.z
	if dif_x > 15:
		map_floor.position.x += 25
	elif dif_x < -15:
		map_floor.position.x -= 25
	if dif_z > 15:
		map_floor.position.z += 25
	elif dif_z < -15:
		map_floor.position.z -= 25
		
	
	



	
