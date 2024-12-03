extends RigidBody3D

  
var attraction_speed: float = 10.0 
var experience_points: int = 15 
@onready var attraction_area = $AttractionArea
@onready var gather_area = $GatherArea
@onready var ball_mesh = $Sphere
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var soound_player = $AudioStreamPlayer3D
var attract := false
var gathered := false



func _physics_process(delta):
	if attract:
		var direction = (player.global_transform.origin - global_transform.origin).normalized()
		var distance = global_transform.origin.distance_to(player.global_transform.origin)

		var attraction_strength = clamp(1.0 / distance, 0.8, 1.0)  # Mocniejsze przyciąganie bliżej
		var target_velocity = direction * attraction_speed

		linear_velocity = linear_velocity.lerp(target_velocity, attraction_strength * delta)



func _on_attraction_area_body_entered(body: Node3D) -> void:
	if body == player:
		attract = true
		attraction_area.monitorable = false
		attraction_area.monitoring = false
	
		

func set_ball(exp):
	global_transform.origin.y += 0.5
	experience_points = exp


func _on_gather_area_body_entered(body: Node3D) -> void:
	if body == player and not gathered:
		gathered = true
		player.get_experience(experience_points)
		ball_mesh.hide()
		var random_pitch = randf_range(0.000, 0.050)
		soound_player.pitch_scale += random_pitch
		soound_player.play()


func _on_audio_stream_player_3d_finished() -> void:
	queue_free()
