extends "res://_NokSnowdancer/characters/snowdancer/projectiles/SnowdancerProjectile.gd"

#	--
func disable():
	.disable()
	
	self.play_sound("Shatter")
	self.spawn_particle_effect_relative(self.creator.vfx_table.Misc1, Vector2(0, 0))
	

func tick():
	.tick()
	
	#	--	MELEE HITTABLE
	for hbox in self.creator.opponent.get_active_hitboxes():
		if self.hurtbox.overlaps(hbox):
			if (not hbox is ThrowBox) and hbox.hits_projectiles == true:
				self.current_state().terminate_hitboxes()
				self.creator.opponent.projectile_free_cancel()
				self.global_hitlag(4)
				
				self.disable()
