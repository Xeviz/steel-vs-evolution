extends Enemy
class_name BasicEnemy


func _on_attack_range_area_body_entered(body: Node3D) -> void:
	if body is Player:
		player_in_range = true


func _on_attack_range_area_body_exited(body: Node3D) -> void:
	if body is Player:
		player_in_range = false



func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "AttackNLA":
		attack_finished = true
