extends CharacterBody3D

var speed: int
var health: int
	
func receive_damage(damage_amount):
	health -= damage_amount
	
func set_stats_from_recipe(recipe):
	speed = recipe["speed"]
	health = recipe["health"]
