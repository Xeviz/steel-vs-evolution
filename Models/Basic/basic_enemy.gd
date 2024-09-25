extends Enemy
class_name BasicEnemy

@onready var model = $Armature
@onready var animation_tree = $AnimationTree
@onready var animation_state = $AnimationTree.get("parameters/playback")


	
func receive_damage(damage_amount, damage_source):
	health -= damage_amount
	if health<=0:
		die(-health, damage_source)
	
func set_stats_from_recipe(recipe):
	speed = recipe["speed"]
	health = recipe["health"]
	experience = recipe["experience"]
	
func die(damage_overkill, damage_source):
	global_data.slain_enemies+=1
	if damage_source=="bullet":
		die_from_bullet(damage_overkill)
	animation_state.travel("DieNLA")


func die_from_bullet(damage_overkill):
	pass
