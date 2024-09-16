extends State
class_name EnemyAttack

var player: CharacterBody3D
@export var enemy: CharacterBody3D


func enter():
	player = get_tree().get_first_node_in_group("Player")

func update(delta: float):
	pass
