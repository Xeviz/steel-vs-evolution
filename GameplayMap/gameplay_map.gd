extends Node3D
class_name GameplayMap


@onready var gameplay_ui = $GameplayUI
@onready var pause_menu = $PauseMenu
@onready var end_game_menu = $GameEndUi
@onready var enemy_spawner = $EnemySpawner
@export var map_floor: Node3D
@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("Player")
@onready var customization_scene = preload("res://CustomizationArea/character_creation_zone.tscn")
@onready var level_up_scene = preload("res://InterfaceComponents/GameplayUI/level_up_window.tscn")


var dif_z: float
var dif_x: float
var game_time: int

func _ready() -> void:
	background_music_player.play_gameplay_music()

func _process(delta):
	_check_if_slide_map()
	if Input.is_action_just_pressed("ui_accept"):
		proceed_to_customization_scene()
		
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
	update_gameplay_ui_data(delta)
		
func update_gameplay_ui_data(delta):
	gameplay_ui.update_time(delta)
	gameplay_ui.update_enemies_slain()
	gameplay_ui.update_level()
	gameplay_ui.update_health()

func proceed_to_customization_scene():
	go_to_creation_zone()
	player.go_to_customization_state()

func load_gameplay_ui_data():
	gameplay_ui.load_weapons_icons(player.lower_body.upper_body.weapons.get_children())
	gameplay_ui.load_time_data()

func pause_game():
	pause_menu.unpause_delay = 0.3
	get_tree().paused = true
	pause_menu.show()

func unpause_game():
	get_tree().paused = false
	pause_menu.hide()
	
func activate_level_up_window():
	get_tree().paused = true
	var new_level_up_scene = level_up_scene.instantiate()
	add_child(new_level_up_scene)
	new_level_up_scene.get_random_upgrades(player.lower_body.upper_body.weapons.get_children())
	


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

func end_game(is_game_won):
	global_data.add_coins(is_game_won)
	end_game_menu.set_labels(is_game_won)
	get_tree().paused = true
	end_game_menu.show()
	
