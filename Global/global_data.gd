extends Node

var config = ConfigFile.new()
var base_max_health = 150
var base_speed = 250
var coins = 3777


#current_session
var player: Player
var slain_enemies := 0
var construction_points := 1
var attached_weapons := 0
var gameplay_time := 0.0

var amount_of_enemies_spawned := 0
var minimum_amount_of_enemies := 15
var maximum_amount_of_enemies := 40
var time_to_spawn_boss := false
var stop_spawning_enemies := false
var amount_of_bosses_spawned := 0
var seconds := 0
var minutes := 0

#description, current_bonus, current_level, increase_per_level
var menu_progressions = {
	"starting_cp": ["Increase starting CP", 2, 2, 1],
	"minigun_damage": ["Increase X % of minigun damage", 0, 0, 10],
	"shotgun_damage": ["Increase X % of shotgun damage", 0, 0, 10],
	"chainsaw_damage": ["Increase X % of chainsaw damage", 50, 5, 10],
	"rocket_launcher_damage": ["Increase X % of rocket launcher damage", 40, 4, 10]
}

func add_coins(has_game_been_won):
	if has_game_been_won:
		coins+=1000
	coins+=slain_enemies
	config.set_value("menu_progressions", "coins", coins)
	config.save("res://Saves/gameprogress.cfg")
	
func restart_session():
	construction_points = 1
	attached_weapons = 0
	gameplay_time = 0.0

	amount_of_enemies_spawned = 0
	minimum_amount_of_enemies = 15
	maximum_amount_of_enemies = 40
	time_to_spawn_boss = false
	stop_spawning_enemies = false
	amount_of_bosses_spawned = 0
	seconds = 57
	minutes = 0
	
func save_menu_progress():
	config.set_value("menu_progressions", "starting_cp", menu_progressions["starting_cp"])
	config.set_value("menu_progressions", "minigun_damage", menu_progressions["minigun_damage"])
	config.set_value("menu_progressions", "shotgun_damage", menu_progressions["shotgun_damage"])
	config.set_value("menu_progressions", "chainsaw_damage", menu_progressions["chainsaw_damage"])
	config.set_value("menu_progressions", "rocket_launcher_damage", menu_progressions["rocket_launcher_damage"])
	config.set_value("menu_progressions", "coins", coins)
	config.save("res://Saves/gameprogress.cfg")
	
func load_menu_progress():
	var loaded_data = config.load("res://Saves/gameprogress.cfg")
	if loaded_data == OK:
		menu_progressions["starting_cp"] = config.get_value("menu_progressions", "starting_cp", ["Increase starting CP", 0, 0, 1])
		menu_progressions["minigun_damage"] = config.get_value("menu_progressions", "minigun_damage", ["Increase X % of minigun damage", 0, 0, 10])
		menu_progressions["shotgun_damage"] = config.get_value("menu_progressions", "shotgun_damage", ["Increase X % of minigun damage", 0, 0, 10])
		menu_progressions["chainsaw_damage"] = config.get_value("menu_progressions", "chainsaw_damage", ["Increase X % of minigun damage", 0, 0, 10])
		menu_progressions["rocket_launcher_damage"] = config.get_value("menu_progressions", "rocket_launcher_damage", ["Increase X % of minigun damage", 0, 0, 10])
		coins = config.get_value("menu_progressions", "coins", 0)
		construction_points += menu_progressions["starting_cp"][1]
		
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



var basic_enemy_recipes = {
	0: {"speed": 120, "health": 50, "experience": 3, "damage": 10},
	1: {"speed": 120, "health": 60, "experience": 3, "damage": 11},
	2: {"speed": 120, "health": 70, "experience": 4, "damage": 12},
	3: {"speed": 120, "health": 90, "experience": 4, "damage": 14},
	4: {"speed": 120, "health": 110, "experience": 4, "damage": 16},
	5: {"speed": 120, "health": 130, "experience": 4, "damage": 18},
	6: {"speed": 120, "health": 160, "experience": 5, "damage": 20},
	7: {"speed": 120, "health": 190, "experience": 5, "damage": 22},
	8: {"speed": 120, "health": 220, "experience": 5, "damage": 24},
	9: {"speed": 120, "health": 250, "experience": 5, "damage": 26},
	10: {"speed": 120, "health": 280, "experience": 6, "damage": 28},
	11: {"speed": 120, "health": 310, "experience": 6, "damage": 30},
	12: {"speed": 120, "health": 340, "experience": 6, "damage": 32},
	13: {"speed": 120, "health": 370, "experience": 6, "damage": 34},
	14: {"speed": 120, "health": 400, "experience": 7, "damage": 36},
	15: {"speed": 120, "health": 440, "experience": 7, "damage": 38},
	16: {"speed": 120, "health": 480, "experience": 7, "damage": 40},
	17: {"speed": 120, "health": 520, "experience": 7, "damage": 42},
	18: {"speed": 120, "health": 560, "experience": 8, "damage": 44},
	19: {"speed": 120, "health": 600, "experience": 8, "damage": 46},
	20: {"speed": 120, "health": 650, "experience": 8, "damage": 48},
	21: {"speed": 120, "health": 700, "experience": 8, "damage": 50},
	22: {"speed": 120, "health": 750, "experience": 9, "damage": 52},
	23: {"speed": 120, "health": 800, "experience": 9, "damage": 54},
	24: {"speed": 120, "health": 850, "experience": 9, "damage": 56},
	25: {"speed": 120, "health": 900, "experience": 9, "damage": 58},
	26: {"speed": 120, "health": 950, "experience": 10, "damage": 60},
	27: {"speed": 120, "health": 1000, "experience": 10, "damage": 62},
	28: {"speed": 120, "health": 1050, "experience": 10, "damage": 64},
	29: {"speed": 120, "health": 1100, "experience": 10, "damage": 66},
	30: {"speed": 120, "health": 1100, "experience": 10, "damage": 66}
}


var basic_boss_recipes = {
	0: {"speed": 140, "health": 500, "experience": 0, "damage": 30},
	1: {"speed": 140, "health": 500, "experience": 0, "damage": 30},
	2: {"speed": 142, "health": 800, "experience": 0, "damage": 33},
	3: {"speed": 144, "health": 1100, "experience": 0, "damage": 36},
	4: {"speed": 146, "health": 1400, "experience": 0, "damage": 39},
	5: {"speed": 148, "health": 1700, "experience": 0, "damage": 42},
	6: {"speed": 150, "health": 2000, "experience": 0, "damage": 45},
	7: {"speed": 152, "health": 2400, "experience": 0, "damage": 48},
	8: {"speed": 154, "health": 2800, "experience": 0, "damage": 51},
	9: {"speed": 156, "health": 3200, "experience": 0, "damage": 54},
	10: {"speed": 158, "health": 3600, "experience": 0, "damage": 57},
	11: {"speed": 160, "health": 4000, "experience": 0, "damage": 60},
	12: {"speed": 162, "health": 4500, "experience": 0, "damage": 63},
	13: {"speed": 164, "health": 5000, "experience": 0, "damage": 66},
	14: {"speed": 166, "health": 5500, "experience": 0, "damage": 67},
	15: {"speed": 168, "health": 6000, "experience": 0, "damage": 70},
	16: {"speed": 170, "health": 6600, "experience": 0, "damage": 73},
	17: {"speed": 172, "health": 7200, "experience": 0, "damage": 76},
	18: {"speed": 174, "health": 7800, "experience": 0, "damage": 79},
	19: {"speed": 176, "health": 8500, "experience": 0, "damage": 82},
	20: {"speed": 178, "health": 9200, "experience": 0, "damage": 85},
	21: {"speed": 180, "health": 10000, "experience": 0, "damage": 88},
	22: {"speed": 182, "health": 10800, "experience": 0, "damage": 91},
	23: {"speed": 184, "health": 11600, "experience": 0, "damage": 94},
	24: {"speed": 186, "health": 12400, "experience": 0, "damage": 97},
	25: {"speed": 188, "health": 13200, "experience": 0, "damage": 100},
	26: {"speed": 190, "health": 14000, "experience": 0, "damage": 103},
	27: {"speed": 192, "health": 15000, "experience": 0, "damage": 106},
	28: {"speed": 194, "health": 16000, "experience": 0, "damage": 109},
	29: {"speed": 196, "health": 17000, "experience": 0, "damage": 112},
	30: {"speed": 198, "health": 18000, "experience": 0, "damage": 115}
}
