extends Button
class_name AttachableItem

var time_to_display = 0.35
var should_display = false
var item_cost = 1
var description = "description"    
var item_name = "weapon"                                                                          

func _process(delta):
	if should_display:
		time_to_display-=delta
	if should_display and time_to_display < 0:
		$Description.visible = true


func load_weapon_data(wep_name):
	item_name = wep_name
	$Label.text = item_name
	$TextureRect.texture = load("res://Textures/Icons/Weapons/" + item_name + ".png")
	item_cost = global_data.base_costs[item_name] + global_data.attached_weapons
	$Description.text = "COST: " + str(item_cost) + "\n" + description

func load_body_part_data(part_name):
	item_name = part_name
	$Label.text = item_name
	$TextureRect.texture = load("res://Textures/Icons/BodyParts/" + item_name + ".png")
	$Description.text = "body part"

func _on_mouse_entered():
	should_display = true
	$TextureRect.modulate = "#ffffffa1"


func _on_mouse_exited():
	should_display = false
	$Description.visible = false
	time_to_display = 0.35
	$TextureRect.modulate = "#ffffff"


func _on_button_down():
	get_parent().get_parent().get_parent().pass_item_preview(item_name)
