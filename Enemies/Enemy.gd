extends CharacterBody3D
class_name Enemy

@onready var collision_shape = $CollisionShape3D
@onready var model = $Armature
@onready var animation_tree = $AnimationTree
@onready var animation_state = $AnimationTree.get("parameters/playback")
@onready var damage_label = $DamageLabel
@onready var death_sound = $DeathPlayer

var speed: int
var health: int
var damage: int
var experience: int
var player_in_range: bool = false
var attack_finished: bool = false
var is_alive := true


func receive_damage(damage_amount, damage_source):
	health -= damage_amount
	damage_label.display_damage(damage_amount)
	if health<=0 and is_alive:
		death_sound.play()
		is_alive = false
		die(-health, damage_source)
	
func set_stats_from_recipe(recipe):
	speed = recipe["speed"]
	health = recipe["health"]
	experience = recipe["experience"]
	damage = recipe["damage"]
	
func die(damage_overkill, damage_source):
	global_data.slain_enemies+=1
	global_data.amount_of_enemies_spawned-=1
	if damage_source=="bullet":
		die_from_bullet(damage_overkill)
	animation_state.travel("DieNLA")

func attack_player():
	animation_state.travel("AttackNLA")

func die_from_bullet(damage_overkill):
	pass

func _on_attack_range_area_body_entered(body: Node3D) -> void:
	pass
