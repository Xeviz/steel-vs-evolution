extends State
class_name EnemyDie

var time_to_death = 0.05
@export var enemy: CharacterBody3D


func update(delta: float):
	if time_to_death>0:
		time_to_death-=delta
	else:
		enemy.queue_free()
