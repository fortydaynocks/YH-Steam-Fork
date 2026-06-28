extends BaseProjectile

export (String) var tag

func _ready():
	._ready()
	
	state_variables.append_array(["tag"])

func _spawn_particle_effect(particle_effect:PackedScene, pos:Vector2, dir = Vector2.RIGHT):
	var effect = ._spawn_particle_effect(particle_effect, pos, dir)
	#	--	self.get_owner().convert_particle_color(effect)
