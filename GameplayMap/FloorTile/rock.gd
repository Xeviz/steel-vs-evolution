extends StaticBody3D

@onready var rock_mesh: MeshInstance3D = $Mesh
@onready var collision_shape: CollisionShape3D = $CollisionShape3D





func _on_render_area_body_exited(body: Node3D) -> void:
	if body is Player:
		queue_free()
