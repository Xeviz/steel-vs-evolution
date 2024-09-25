extends Node


var player: Player
var slain_enemies = 5
var attached_weapons = 0
var gameplay_time = 0.0

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
