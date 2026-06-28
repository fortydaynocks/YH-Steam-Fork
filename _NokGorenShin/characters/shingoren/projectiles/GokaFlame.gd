extends "res://_NokGorenShin/characters/shingoren/projectiles/SG-Projectile.gd"

func hit_by(hitbox):
	self.disable()
	self.get_opponent().projectile_free_cancel()
