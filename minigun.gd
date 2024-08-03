extends Node3D

@export var bullet_scene: PackedScene
@export var fire_rate: float = 0.15

var firing_bullets: Array = []
var reloading_bullets: Array = []

var fire_timer: float = 0.0

func _ready():
	set_process(true)


func _process(delta: float) -> void:
	fire_timer -= delta
	if fire_timer <= 0:
		fire_bullet()
		fire_timer = fire_rate
	print("fire amount:", firing_bullets.size(), "stored amount: ", reloading_bullets.size())

func fire_bullet():
	var bullet
	if reloading_bullets.size() > 0:
		bullet = reloading_bullets.pop_back()
	else:
		bullet = bullet_scene.instantiate()
		bullet.connect_to_weapon(self)
		get_tree().root.add_child(bullet)

	bullet.connect("reloaded", Callable(self, "on_bullet_reloaded"))

	var spawner_transform = $BulletSpawner.global_transform
	var raycast = $BulletSpawner/RayCast3D
	var collision_point = raycast.get_collision_point()
	var direction = (collision_point - spawner_transform.origin).normalized()

	bullet.global_transform = spawner_transform
	bullet.call("fire") 
	firing_bullets.append(bullet)

func on_bullet_reloaded(bullet):
	firing_bullets.erase(bullet)
	reloading_bullets.append(bullet)
