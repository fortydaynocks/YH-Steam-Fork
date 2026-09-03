extends BaseProjectile

export (String) var tag
export (bool) var disable_when_hit = false
export (PackedScene) var disable_particle
export (Vector2) var disable_particle_offset = Vector2(0, 0)
export (String) var disable_sound

export (bool) var auto_rotate = false
export (int) var auto_rotate_offset = 0

#	========================================================================== >
func _ready():
	._ready()
	
	state_variables.append_array(["tag"])

func disable():
	if disable_particle:
		self.spawn_particle_effect_relative(disable_particle, disable_particle_offset)
	
	if len(disable_sound) > 0:
		self.play_sound(disable_sound)
	
	.disable()

func _spawn_particle_effect(particle_effect:PackedScene, pos:Vector2, dir = Vector2.RIGHT):
	var effect = ._spawn_particle_effect(particle_effect, pos, dir)

func hit_by(hitbox):
	.hit_by(hitbox)
	
	if disable_when_hit:
		self.disable()

#	========================================================================== >
func tick():
	.tick()
	
	if auto_rotate:
		var vel = Vector2(self.get_vel().x, self.get_vel().y)
		self.flip.rotation_degrees = rad2deg(vel.angle()) + (auto_rotate_offset * self.get_facing_int())
		if self.get_facing_int() == -1: self.flip.rotation_degrees += 180

	else:
		self.flip.rotation_degrees = 0
