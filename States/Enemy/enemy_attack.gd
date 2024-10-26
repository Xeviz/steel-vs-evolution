extends State
class_name EnemyAttack

var player: CharacterBody3D
@export var enemy: CharacterBody3D
var damage_check_timer: float
var damage_dealt: bool = false

func enter():
	player = get_tree().get_first_node_in_group("Player")
	enemy.attack_player()
	damage_check_timer = 1.35
	damage_dealt = false

func update(delta: float):
	damage_check_timer -= delta
	check_if_alive()
	if damage_check_timer<=0 and not damage_dealt:
		deal_damage()
	if enemy.attack_finished:
		state_transition.emit(self, "EnemyFollowPlayer")

func deal_damage():
	damage_dealt = true
	if enemy.player_in_range:
		player.receive_damage(enemy.damage)
		
func check_if_alive():
	if enemy.health<=0:
		state_transition.emit(self, "EnemyDie")
