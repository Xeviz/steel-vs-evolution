extends Node3D

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("Player")
@export var gameplay_scene = preload("res://GameplayMap/gameplay_map.tscn")

var weapon_scenes = {
	"minigun": preload("res://Player/Weapons/Minigun/minigun.tscn"),
	"shotgun": preload("res://Player/Weapons/Shotgun/shotgun.tscn"),
	"chainsaw": preload("res://Player/Weapons/Chainsaw/chainsaw.tscn"),
	"rocket_launcher": preload("res://Player/Weapons/RocketLauncher/rocket_launcher.tscn")
}

var upper_body_parts_scenes = {
	"upper_body_part_1": preload("res://Player/BodyParts/UpperBodyParts/upper_body_part_1.tscn"),
	"upper_body_part_2": preload("res://Player/BodyParts/UpperBodyParts/upper_body_part_2.tscn"),
}

var lower_body_parts_scenes = {
	"lower_body_part_1": preload("res://Player/BodyParts/LowerBodyParts/lower_body_part_1.tscn"),
	"lower_body_part_2": preload("res://Player/BodyParts/LowerBodyParts/lower_body_part_2.tscn")
}

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		go_to_gameplay_zone()

func show_weapon_preview(item_name):
	var new_weapon = weapon_scenes[item_name].instantiate()
	player.weapons.add_child(new_weapon)
	new_weapon.go_to_preview()
	print(player.weapons.get_children())
	
func chose_item(item_name, previous_upper_body_name):
	if item_name in upper_body_parts_scenes:
		var body_part_scene = upper_body_parts_scenes[item_name]
		player.lower_body.change_upper_body(body_part_scene)
	elif item_name in lower_body_parts_scenes:
		var body_part_scene = lower_body_parts_scenes[item_name]
		var prev_upper_body_scene = upper_body_parts_scenes[previous_upper_body_name]
		player.change_lower_body(body_part_scene)
		player.lower_body.change_upper_body(prev_upper_body_scene)

func go_to_gameplay_zone():
	var new_gameplay_scene = gameplay_scene.instantiate()
	player.get_parent().remove_child(player)
	new_gameplay_scene.add_child(global_data.player)
	player.go_to_gameplay_state()
	
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(new_gameplay_scene)
	get_tree().current_scene = new_gameplay_scene
	
	
	global_data.player.get_player()
	new_gameplay_scene.load_gameplay_ui_data()
