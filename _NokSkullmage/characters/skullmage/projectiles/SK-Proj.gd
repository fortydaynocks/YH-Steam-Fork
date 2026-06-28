extends BaseProjectile

export (String) var tag
export (PackedScene) var disable_particle
export (Vector2) var disable_particle_offset = Vector2(0, 0)
export (String) var disable_sound
export (bool) var is_summon = false

func _ready():
	._ready()
	
	state_variables.append_array(["tag"])

func disable():
	if disable_particle:
		self.spawn_particle_effect_relative(disable_particle, disable_particle_offset)
	
	if len(disable_sound) > 0:
		self.play_sound(disable_sound)
	
	.disable()
	
#	--
