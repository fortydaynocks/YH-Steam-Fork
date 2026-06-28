extends "res://_NokTormentHellsaint/characters/hellsaint/projectiles/THS-Projectile.gd"

var will_sickle = false

#	--
func slice():
	self.tag = "SlicedTerrorStar"
	self.disable_particle = null
	
	$Flip/Particles/ParticleEffect/blood.emitting = false
	$Flip/Particles/ParticleEffect/ring.emitting = false
	
	self.change_state("Slice")

func spike(dir):
	if not dir: return
	if self.current_state().get("deflected"): return
	
	self.tag = "TerrorSpike"
	self.play_sound("Spike")
	
	self.change_state("Spike")
	self.disable_particle = preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Misc2.tscn")
	$Flip/Particles/ParticleEffect/ring.emitting = false
	
	self.reset_momentum()
	self.apply_force(dir.x, dir.y)
	
func sickle():
	self.tag = "Sickle"
	self.play_sound("Sickle")
	self.play_sound("Sickle2")
	
	self.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Ring1.tscn"), Vector2(0, 0))
	
	self.change_state("Sickle")
