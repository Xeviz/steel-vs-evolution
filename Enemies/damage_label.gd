extends Label3D
class_name DamageLabel

@onready var time_to_vanish = 0.7
@onready var fade_speed = 0.7

func _physics_process(delta: float) -> void:
	time_to_vanish -= delta
	
	position.y += delta * 0.5
	modulate.a = max(modulate.a - fade_speed * delta, 0)
	if time_to_vanish <= 0:
		queue_free()
		

func display_damage(value, height, pos_x, pos_z):
	global_position.x = pos_x
	global_position.z = pos_z
	position.y = height
	time_to_vanish = 0.7
	text = str(value)
	
