extends CharacterBody3D

@onready var player = get_parent().get_node("Player")
var speed = 120
var health = 120
var direction


func _ready():
	pass


func _process(delta):
	move_towards_player(delta)
	
func move_towards_player(delta):
	var target_position = player.global_transform.origin
	velocity = (target_position - global_transform.origin).normalized() * speed * delta
	move_and_slide()

func receive_damage(damage_amount):
	health -= damage_amount
	if health<=0:
		queue_free()
