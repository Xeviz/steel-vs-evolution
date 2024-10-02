extends Control

@onready var weapon_icon = preload("res://InterfaceComponents/GameplayUI/weapon_icon.tscn")

@onready var time_label = $TimeCounter
@onready var enemies_slain_label = $SlainCounter
@onready var level_label = $LevelDisplay
@onready var health_label = $HealthDisplay
@onready var level_progress = $LevelProgress
@onready var health_bar = $HealthBar
@onready var icons_container = $HBoxContainer

var stop_time = false
var stage_cleared = false

var seconds: float = 0
var minutes: int = 0
var passed_time: float = 0.0
var level: int = 0


func load_weapons_icons(weapons):
	for weapon in weapons:
		weapon.update_icon_data()
		icons_container.add_child(weapon.weapon_icon)

func update_weapons_icons():
	for weapon_icon in icons_container.get_children():
		pass
	pass

func _ready():
	minutes = global_data.gameplay_minute
	update_enemies_slain()
	update_level()
	update_health()
	time_label.text = str(minutes) + ":" + str(seconds)

func update_time(delta):
	passed_time += delta
	if passed_time < 1:
		return
	passed_time-=1
	
	if seconds == 59:
		seconds = 0
		minutes+=1
		global_data.gameplay_minute+=1
		if minutes in [1,3,7,12,18,25]:
			get_parent().go_to_creation_zone()
	else:
		seconds+=1
	time_label.text = str(minutes) + ":" + str(seconds)

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
