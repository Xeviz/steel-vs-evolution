extends ColorRect
class_name ProgressOption

@export var option_image: TextureRect
@export var upgrade_button: Button
@export var cost_label: Label
@export var description_label: Label
@export var current_bonus_label: Label

var upgrades_menu : Control
var upgrade_costs = [200, 400, 800, 1600, 3200]
var current_level := 0
var current_cost := -1
var current_bonus := 0
var upgrade_name := "TBD"

#description, current_bonus, current_level, increase_per_level
#var menu_progressions = {
	#"starting_cp": ["Increase starting CP", 2, 2, 1],
	#"minigun_damage": ["Increase minigun % damage", 0, 0, 10],
	#"shotgun_damage": ["Increase shotgun % damage", 0, 0, 10],
	#"chainsaw_damage": ["Increase chainsaw % damage", 0, 0, 10],
	#"rocket_launcher_damage": ["Increase rocket launcher % damage", 0, 0, 10]
#}

func load_progress_data(upgrade_name):
	self.upgrade_name = upgrade_name
	if global_data.menu_progressions[upgrade_name][2]<5:
		current_cost = upgrade_costs[global_data.menu_progressions[upgrade_name][2]]
		cost_label.text = "COST: " + str(current_cost)
	else:
		upgrade_button.hide()
		cost_label.text = "MAX BONUS REACHED"
		color.a = 1.0
	description_label.text = global_data.menu_progressions[upgrade_name][0]
	current_bonus_label.text = "CURRENTLY: +" + str(global_data.menu_progressions[upgrade_name][1])
	


func _on_button_button_down() -> void:
	if global_data.coins>=current_cost:
		global_data.coins-=current_cost
		global_data.menu_progressions[upgrade_name][2]+=1
		global_data.menu_progressions[upgrade_name][1]+=global_data.menu_progressions[upgrade_name][3]
		load_progress_data(upgrade_name)
		get_parent().get_parent().get_parent().refresh_coins_info()
		global_data.save_menu_progress()
