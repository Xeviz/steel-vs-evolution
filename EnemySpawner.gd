extends Node3D

var time_to_spawn = 2
@export var enemy_scene: PackedScene
@onready var right_spawn = $Right

func _ready():
	pass # Replace with function body.



func _process(delta):
	time_to_spawn-=delta
	if time_to_spawn<0:
		var enemy = enemy_scene.instantiate()
		enemy.position = right_spawn.position
		time_to_spawn = 2
		get_parent().add_child(enemy)
		
