extends "res://_NokBetrayer/characters/betrayer/projectiles/BT-Projectile.gd"

func disable():
	self.play_sound("Collide")
	self.play_sound("Collide2")
	self.screen_bump(Vector2(0, 0), 8, 0.1)
	self.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTHit3.tscn"), Vector2(0, 0))
		
	if self.is_grounded() == true:
		self.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTFloorIntro.tscn"), Vector2(0, 0))
	
	self.get_owner().summon_knight(self.get_pos(), "Justice")
	
	.disable()
