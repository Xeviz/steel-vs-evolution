extends Control

@onready var weapon_icon = preload("res://InterfaceComponents/GameplayUI/weapon_icon.tscn")

@onready var time_label = $TimeCounter
@onready var enemies_slain_label = $SlainCounter
@onready var level_label = $LevelDisplay
@onready var health_label = $HealthDisplay
@onready var level_progress = $LevelProgress
@onready var health_bar = $HealthBar




var passed_time = 0.0
var level = 0
var customization_intervals = [1,3,7,12,18,25, 30]

func load_time_data():
	time_label.text = "%02d:%02d" % [global_data.minutes, global_data.seconds]

func load_weapons_icons(weapons):
	for weapon in weapons:
		var new_weapon_icon = weapon_icon.instantiate()
		new_weapon_icon.load_icon_data(weapon.weapon_name, weapon.weapon_level)
		weapon.icon_refference = new_weapon_icon
		$HBoxContainer.add_child(new_weapon_icon)


func update_time(delta):
	if global_data.seconds == 0 and global_data.minutes in customization_intervals and global_data.amount_of_enemies_spawned>0:
		global_data.stop_spawning_enemies = true
		return
	elif global_data.seconds == 0 and global_data.minutes in customization_intervals:
		passed_time = 0.0
		if global_data.minutes == 30:
			get_parent().end_game(true)
		else:
			get_parent().proceed_to_customization_scene()
	passed_time += delta
	if passed_time < 1:
		return
	passed_time-=1
	
	if global_data.seconds == 59:
		global_data.seconds = 0
		global_data.minutes+=1
		global_data.time_to_spawn_boss = true
		global_data.minimum_amount_of_enemies+=1
		global_data.maximum_amount_of_enemies+=1
		get_parent().enemy_spawner.update_recipes()
	else:
		global_data.seconds+=1
	time_label.text = "%02d:%02d" % [global_data.minutes, global_data.seconds]

func update_level():
	if global_data.player.level != level:
		level = global_data.player.level
		level_label.text = "Lv."+str(level)
		level_progress.max_value = global_data.player.experience_to_level_up
	level_progress.value = global_data.player.experience
	
func update_health():
	health_bar.max_value = global_data.player.max_health
	health_bar.value = global_data.player.health
	health_label.text = str(health_bar.value) + "/" + str(health_bar.max_value)
		

func update_enemies_slain():
	enemies_slain_label.text = "ENEMIES SLAIN: " + str(global_data.slain_enemies)
