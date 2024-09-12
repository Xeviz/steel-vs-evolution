extends Control

var time_to_display = 0.35
var should_display = false
var weapon_cost = 1
var description = "description"    
var weapon_name = "weapon"                                                                                    

func _process(delta):
	if should_display:
		time_to_display-=delta
	if should_display and time_to_display < 0:
		$Description.visible = true


func load_item_data(wep_name):
	weapon_name = wep_name
	$Label.text = weapon_name
	$TextureRect.texture = load("res://Textures/Weapons/" + weapon_name + ".png")
	weapon_cost = global_data.base_costs[weapon_name] + global_data.attached_weapons
	$Description.text = "COST: " + str(weapon_cost) + "\n" + description

func _on_mouse_entered():
	should_display = true
	$TextureRect.modulate = "#ffffffa1"


func _on_mouse_exited():
	should_display = false
	$Description.visible = false
	time_to_display = 0.35
	$TextureRect.modulate = "#ffffff"


func _on_button_down():
	get_parent().get_parent().pass_weapon_preview(weapon_name)
