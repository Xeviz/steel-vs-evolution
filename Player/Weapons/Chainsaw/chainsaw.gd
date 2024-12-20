extends MeleeWeapon
class_name Chainsaw



@onready var damage_area = $DamageArea
@onready var animation_tree = $AnimationTree
@onready var animation_state = $AnimationTree.get("parameters/playback")
@onready var cutting_player: AudioStreamPlayer3D = $CuttingPlayer
@onready var grinding_player: AudioStreamPlayer3D = $GrindingPlayer


var base_cut_interval: float = 0.1
var cut_interval: float = 0.1
var cut_interval_modifier = 1.0

var base_cut_damage: int = 10
var cut_damage: int = 10
var cut_damage_modifier: int = 1.0

var no_enemy_under_blade := true


func _ready() -> void:
	apply_menu_progression()
	weapon_name = "Chainsaw"
	upgrade_variants = {
	1: "Increase cutting frequency by 0.02s",
	2: "Increase cut damage by 2",
	3: "Increase cut damage by 10%",
	4: "Increase cut damage by 1 and cut frequency by 0.01s"
}

func apply_menu_progression():
	cut_damage_modifier += global_data.menu_progressions["chainsaw_damage"][1]*0.01
	cut_damage = int(base_cut_damage*cut_damage_modifier)

func deal_damage_in_area():
	no_enemy_under_blade = true
	for enemy in damage_area.get_overlapping_bodies():
		if enemy is Enemy:
			no_enemy_under_blade = false
			enemy.receive_damage(cut_damage, "blade")
	if !no_enemy_under_blade and !grinding_player.is_playing():
		grinding_player.play()
	elif no_enemy_under_blade:
		grinding_player.stop()
			
func apply_upgrade(variant_id):
	if variant_id == 1:
		upgrade_interval(-0.02)
	elif variant_id == 2:
		upgrade_damage(2)
	elif variant_id == 3:
		upgrade_damage(0.1)
	elif variant_id == 3:
		upgrade_damage(1)
		upgrade_interval(-0.01)

func upgrade_damage(upgrade_value):
	if upgrade_value < 1 and upgrade_value > -1:
		cut_damage_modifier+=upgrade_value
	else:
		base_cut_damage+=upgrade_value
	cut_damage = base_cut_damage*cut_damage_modifier
	
func upgrade_interval(upgrade_value):
	if upgrade_value < 1 and upgrade_value > -1:
		cut_interval_modifier+=upgrade_value
	else:
		base_cut_interval+=upgrade_value
	cut_damage = base_cut_interval*cut_interval_modifier
