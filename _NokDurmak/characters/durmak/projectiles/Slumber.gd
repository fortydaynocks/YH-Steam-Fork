extends "res://_NokDurmak/characters/durmak/projectiles/DM-Projectile.gd"

func hit_by(hitbox):
	.hit_by(hitbox)
	
	self.disable()

func tick():
	.tick()
	
	if current_tick == 1:
		self.play_sound("Slumber")
