extends State
class_name EnemyFollowPlayer

var player: CharacterBody3D
@export var enemy: CharacterBody3D


func enter():
	enemy.attack_finished = false
	player = get_tree().get_first_node_in_group("Player")


func update(delta):
	check_if_alive()
	check_if_attack()

func physics_update(delta: float):
	move_towards_player(delta)


func move_towards_player(delta):
	var target_position = player.global_transform.origin
	enemy.look_at(target_position, Vector3.UP)
	enemy.rotate_y(deg_to_rad(180))
	
	enemy.velocity = (target_position - enemy.global_transform.origin).normalized() * enemy.speed * delta
	enemy.move_and_slide()
	
func check_if_alive():
	if enemy.health<=0:
		state_transition.emit(self, "EnemyDie")
		
func check_if_attack():
	if enemy.player_in_range:
		state_transition.emit(self, "EnemyAttack")
