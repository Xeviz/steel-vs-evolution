extends State
class_name EnemyDie

var time_to_death = 7
var player: CharacterBody3D
@export var enemy: CharacterBody3D


func enter():
	player = get_tree().get_first_node_in_group("Player")
	enemy.collision_shape.disabled = true
	player.get_experience(enemy.experience)

func update(delta: float):
	if time_to_death>0:
		time_to_death-=delta
	else:
		enemy.queue_free()
