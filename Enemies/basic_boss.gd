extends BasicEnemy
class_name BasicBoss


func _on_attack_range_area_body_entered(body: Node3D) -> void:
	if body is Player:
		player_in_range = true


func _on_attack_range_area_body_exited(body: Node3D) -> void:
	if body is Player:
		player_in_range = false




func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "AttackNLA":
		attack_finished = true
		if player_in_range:
			player.receive_damage(damage)


func die(damage_overkill, damage_source):
	global_data.slain_enemies+=1
	global_data.amount_of_enemies_spawned-=1
	global_data.construction_points+=1
	if damage_source=="bullet":
		die_from_bullet(damage_overkill)
	animation_state.travel("DieNLA")
