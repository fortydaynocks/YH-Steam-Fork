extends BaseProjectile

export (String) var tag
export (PackedScene) var spawn_particle
export (Vector2) var spawn_particle_offset = Vector2(0, 0)
export (String) var spawn_sound
export (PackedScene) var disable_particle
export (Vector2) var disable_particle_offset = Vector2(0, 0)
export (String) var disable_sound

func _ready():
	._ready()
	
	state_variables.append_array(["tag"])

func disable():
	if disable_particle: self.spawn_particle_effect_relative(disable_particle, disable_particle_offset)
	if len(disable_sound) > 0: self.play_sound(disable_sound)
	
	.disable()

func _spawn_particle_effect(particle_effect:PackedScene, pos:Vector2, dir = Vector2.RIGHT):
	var effect = ._spawn_particle_effect(particle_effect, pos, dir)

#	--
func tick():
	.tick()
	
	if current_tick == 1:
		if spawn_particle: self.spawn_particle_effect_relative(spawn_particle, spawn_particle_offset)
		if len(spawn_sound) > 0: self.play_sound(spawn_sound)

func _process(delta):
	._process(delta)
	
	if has_node("%Info"):
		$"%Info".visible = self.is_ghost and (not disabled)
