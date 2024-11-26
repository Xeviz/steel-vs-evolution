extends State
class_name EnemyAttack

@export var enemy: CharacterBody3D
var damage_dealt: bool = false

func enter():
	
	enemy.attack_player()
	damage_dealt = false

func update(delta: float):
	check_if_alive()
	if enemy.attack_finished:
		state_transition.emit(self, "EnemyFollowPlayer")

		
func check_if_alive():
	if enemy.health<=0:
		state_transition.emit(self, "EnemyDie")
