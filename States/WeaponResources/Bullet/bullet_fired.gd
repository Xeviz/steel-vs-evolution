extends State
class_name BulletFired


@export var bullet: Bullet


func enter():
	bullet.starting_position = bullet.global_position
	if bullet.bullet_area:
		bullet.bullet_area.monitoring = true
		bullet.bullet_area.monitorable = true
		bullet.bullet_mesh.visible = true
	
func physics_update(delta):
	bullet.translate(bullet.velocity * delta)
	if bullet.global_position.distance_to(bullet.starting_position) >= bullet.range or bullet.penetrated_targets >= bullet.penetration:
		bullet.stored.emit(bullet)
		state_transition.emit(self, "BulletStored")
		
		
