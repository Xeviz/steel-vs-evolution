extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var vfx_smoke: GPUParticles3D = $VFX_Smoke
@onready var light: OmniLight3D = $OmniLight3D

func play_explosion():
	light.show()
	animation_player.play("ExplosionAnimation")
	
	
func change_scale(new_scale: float):
	if vfx_smoke.process_material is ParticleProcessMaterial:
		var material := vfx_smoke.process_material as ParticleProcessMaterial
		material.scale_min = new_scale - 0.1
		material.scale_max = new_scale


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	light.hide()
