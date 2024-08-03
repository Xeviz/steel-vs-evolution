extends Node3D

enum State { FIRING, RELOADING }

var speed = 5
var damage = 10
var penetration = 1
var penetrated_targets = 0
var state = State.RELOADING
var spawn_position = Vector3.ZERO

@onready var starting_position = position
@onready var ray = $RayCast3D
@onready var source_weapon

func connect_to_weapon(weapon):
	source_weapon = weapon

func _ready():
	spawn_position = global_transform.origin
	set_state(State.FIRING)

func _process(delta):
	match state:
		State.FIRING:
			update_firing(delta)
		State.RELOADING:
			update_reloading(delta)
	

func set_state(new_state):
	state = new_state
	match state:
		State.FIRING:
			$BulletArea.monitoring = true
			$BulletArea.monitorable = true
			$MeshInstance3D.visible = true
		State.RELOADING:
			$BulletArea.monitoring = false
			$BulletArea.monitorable = false
			$MeshInstance3D.visible = false
			global_transform.origin = spawn_position
			penetrated_targets = 0

func update_firing(delta):
	position += transform.basis * Vector3(0, 0, -speed) * delta
	if position.distance_to(starting_position) >= 15 or penetrated_targets>=penetration:
		set_state(State.RELOADING)
		source_weapon.on_bullet_reloaded(self)

func update_reloading(delta):
	pass

func fire():
	starting_position = position
	set_state(State.FIRING)


func _on_bullet_area_body_entered(body):
	penetrated_targets += 1
	body.receive_damage(damage)
