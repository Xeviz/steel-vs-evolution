extends CharacterBody3D
class_name Enemy

@onready var collision_shape = $CollisionShape3D

var speed: int
var health: int
var experience: int
	
func receive_damage(damage_amount, damage_source):
	health -= damage_amount
	if health<=0:
		global_data.slain_enemies-=1
		die(-health, damage_source)
	
func set_stats_from_recipe(recipe):
	speed = recipe["speed"]
	health = recipe["health"]
	experience = recipe["experience"]
	
func die(damage_overkill, damage_source):
	if damage_source=="bullet":
		die_from_bullet(damage_overkill)

func die_from_bullet(damage_overkill):
	pass
