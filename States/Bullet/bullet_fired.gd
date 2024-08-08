extends State
class_name BulletFired


@export var bullet: Bullet


func enter():
	bullet.starting_position = bullet.position
	if bullet.bullet_area:
		bullet.bullet_area.monitoring = true
		bullet.bullet_area.monitorable = true
		bullet.bullet_mesh.visible = true
	
func physics_update(delta):
	bullet.position += bullet.transform.basis * Vector3(0, 0, -bullet.speed) * delta
	if bullet.position.distance_to(bullet.starting_position) >= 15 or bullet.penetrated_targets>=bullet.penetration:
		bullet.stored.emit(bullet)
		state_transition.emit(self, "BulletStored")
		
		
