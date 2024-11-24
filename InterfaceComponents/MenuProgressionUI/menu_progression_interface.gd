extends Control

@export var progress_option_scene: PackedScene
@onready var upgrades_container: VBoxContainer = $UpgradesContainer/VBoxContainer
@onready var coin_info_label: Label = $CoinInfo

func _ready() -> void:
	initialize_upgrades()
	refresh_coins_info()
	
func initialize_upgrades():
	var starting_cp = progress_option_scene.instantiate()
	upgrades_container.add_child(starting_cp)
	starting_cp.load_progress_data("starting_cp")
	
	var minigun_damage = progress_option_scene.instantiate()
	upgrades_container.add_child(minigun_damage)
	minigun_damage.load_progress_data("minigun_damage")
	
	var shotgun_damage = progress_option_scene.instantiate()
	upgrades_container.add_child(shotgun_damage)
	shotgun_damage.load_progress_data("shotgun_damage")
	
	var chainsaw_damage = progress_option_scene.instantiate()
	upgrades_container.add_child(chainsaw_damage)
	chainsaw_damage.load_progress_data("chainsaw_damage")
	
	var rocket_launcher_damage = progress_option_scene.instantiate()
	upgrades_container.add_child(rocket_launcher_damage)
	rocket_launcher_damage.load_progress_data("rocket_launcher_damage")

func _on_back_button_button_down() -> void:
	get_tree().change_scene_to_file("res://InterfaceComponents/MainMenuUI/main_menu.tscn")
	
func refresh_coins_info():
	coin_info_label.text = "COINS: " + str(global_data.coins)
