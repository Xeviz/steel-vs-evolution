extends Node3D
class_name GameplayMap

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("Player")
@export var map_floor: Node3D
@onready var customization_scene = preload("res://CustomizationArea/character_creation_zone.tscn")
var dif_z: float
var dif_x: float


func _process(delta):
	_check_if_slide_map()
	if Input.is_action_just_pressed("ui_accept"):
		player.go_to_customization_state()
		go_to_creation_zone()
		
	
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
		
	
	
func go_to_creation_zone():
	var new_customization_scene = customization_scene.instantiate()
	player.get_parent().remove_child(player)
	new_customization_scene.add_child(global_data.player)
	
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(new_customization_scene)
	get_tree().current_scene = new_customization_scene
	
	global_data.player.get_player()

