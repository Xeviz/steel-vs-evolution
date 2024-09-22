extends Node3D

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("Player")
@export var gameplay_scene = preload("res://GameplayMap/gameplay_map.tscn")

var weapon_scenes = {
	"minigun": preload("res://Player/Weapons/Minigun/minigun.tscn"),
	"shotgun": preload("res://Player/Weapons/Shotgun/shotgun.tscn")
}

var body_part_scenes = {
	"body_part_2": preload("res://Player/BodyParts/body_part_2.tscn"),
	"body_part_4": preload("res://Player/BodyParts/body_part_4.tscn")
}

func _process(delta):
	if Input.is_action_just_pressed("mouse_pointer_in_creator"):
		show_item_preview("minigun")
		
	if Input.is_action_just_pressed("ui_cancel"):
		go_to_gameplay_zone()

func show_item_preview(item_name):
	if item_name in weapon_scenes:
		var new_weapon = weapon_scenes[item_name].instantiate()
		player.weapons.add_child(new_weapon)
		new_weapon.go_to_preview()
	else:
		var new_body_part = body_part_scenes[item_name].instantiate()
		player.lower_body.lower_collider_area.add_child(new_body_part)
		new_body_part.go_to_preview()

func go_to_gameplay_zone():
	var new_gameplay_scene = gameplay_scene.instantiate()
	player.get_parent().remove_child(player)
	new_gameplay_scene.add_child(global_data.player)
	player.go_to_gameplay_state()
	
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(new_gameplay_scene)
	get_tree().current_scene = new_gameplay_scene
	
	global_data.player.get_player()
