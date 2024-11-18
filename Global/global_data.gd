extends Node

var base_max_health = 150
var base_speed = 250


#current_session
var player: Player
var slain_enemies := 0
var construction_points := 5
var attached_weapons := 0
var gameplay_time := 0.0

var amount_of_enemies_spawned := 0
var minimum_amount_of_enemies := 15
var maximum_amount_of_enemies := 40
var time_to_spawn_boss := false
var stop_spawning_enemies := false
var amount_of_bosses_spawned := 0
var seconds := 57
var minutes := 0



var base_costs = {
	"minigun": 1,
	"shotgun": 2,
	"chainsaw": 1,
	"rocket_launcher": 3
}

var weapons_scenes_paths = {
	"Minigun": "res://Player/Weapons/Minigun/minigun.tscn",
	"Shotgun": "res://Player/Weapons/Shotgun/shotgun.tscn",
	"Chainsaw": "res://Player/Weapons/Chainsaw/chainsaw.tscn",
	"RocketLauncher": "res://Player/Weapons/RocketLauncher/rocket_launcher.tscn"
}

var weapons_icons_paths = {
	"Minigun": "res://Textures/Icons/Weapons/minigun.png",
	"Shotgun": "res://Textures/Icons/Weapons/shotgun.png",
	"Chainsaw": "res://Textures/Icons/Weapons/chainsaw.png",
	"RocketLauncher": "res://Textures/Icons/Weapons/rocket_launcher.png"
}


var lower_bodies_stats = {
	"lower_body_part_1": {
		"base_health_bonus": 0,
		"base_speed_bonus": 50,
	},
	"lower_body_part_2": {
		"base_health_bonus": 150,
		"base_speed_bonus": 0,
	},
	"lower_body_part_3": {
		"base_health_bonus": 150,
		"base_speed_bonus": 0,
	}
}

var upper_bodies_stats = {
	"upper_body_part_1": {
		"base_health_bonus": 200,
		"base_speed_bonus": 0,
	},
	"upper_body_part_2": {
		"base_health_bonus": 300,
		"base_speed_bonus": -50,
	}
}
