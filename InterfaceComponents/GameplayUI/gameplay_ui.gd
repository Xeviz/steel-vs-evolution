extends Control

@onready var weapon_icon = preload("res://InterfaceComponents/GameplayUI/weapon_icon.tscn")
@onready var time_label = $TimeCounter
@onready var enemies_slain_label = $SlainCounter
@onready var level_label = $LevelDisplay
@onready var level_progress = $LevelProgress
var seconds = 0
var minutes = 0
var passed_time = 0.0
var level = 0

func load_weapons_icons(weapons):
	for weapon in weapons:
		var new_weapon_icon = weapon_icon.instantiate()
		new_weapon_icon.load_icon_data(weapon.weapon_name, weapon.weapon_level)
		$HBoxContainer.add_child(new_weapon_icon)


func update_time(delta):
	passed_time += delta
	if passed_time < 1:
		return
	passed_time-=1
	
	if seconds == 59:
		seconds = 0
		minutes+=1
	else:
		seconds+=1
	time_label.text = str(minutes) + ":" + str(seconds)

func update_level():
	if global_data.player.level != level:
		level = global_data.player.level
		level_label.text = "Lv."+str(level)
		level_progress.max_value = global_data.player.experience_to_level_up
	level_progress.value = global_data.player.experience
	
		

func update_enemies_slain():
	enemies_slain_label.text = "ENEMIES SLAIN: " + str(global_data.slain_enemies)
