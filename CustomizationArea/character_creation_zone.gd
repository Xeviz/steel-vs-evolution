extends Node3D

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("Player")


func _process(delta):
	if Input.is_action_just_pressed("mouse_pointer_in_creator"):
		show_weapon_preview()
	if Input.is_action_just_pressed("ui_accept"):
		player.is_on_the_map = true
		move_player_to_gameplay_map()

func show_weapon_preview():
	var weapon_scene = preload("res://Player/Weapons/minigun.tscn")
	var new_weapon = weapon_scene.instantiate()
	player.weapons.add_child(new_weapon)
	new_weapon.go_to_preview()

func move_player_to_gameplay_map():
	player.get_parent().remove_child(player)
	player.is_on_the_map = true
	var gameplay_map_scene = preload("res://GameplayMap/gameplay_map.tscn").instantiate()
	gameplay_map_scene.add_child(player)
	get_tree().root.add_child(gameplay_map_scene)
	
	var current_scene = get_tree().current_scene
	if current_scene:
		current_scene.queue_free()
	get_tree().set_current_scene(gameplay_map_scene)
