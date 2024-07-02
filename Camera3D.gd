extends Camera3D

var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null:
		position.x = player.position.x
		position.z = player.position.z
