extends State
class_name BulletStored

@export var bullet: Bullet


func enter():
	bullet.bullet_area.monitoring = false
	bullet.bullet_area.monitorable = false
	bullet.bullet_mesh.visible = false
	bullet.penetrated_targets = 0
	bullet.is_fired = false

func update(_delta):
	if bullet.is_fired == true:
		state_transition.emit(self, "BulletFired")
