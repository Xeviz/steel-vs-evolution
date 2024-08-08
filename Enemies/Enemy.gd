extends CharacterBody3D

var speed = 120
var health = 120


func _ready():
	pass


func _process(delta):
	pass
	
func receive_damage(damage_amount):
	health -= damage_amount
